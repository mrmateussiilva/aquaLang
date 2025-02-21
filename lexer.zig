const std = @import("std");

pub const TokenKind = enum {
    Identifier,
    Keyword,
    Number,
    String,
    Indentation,
    Dedentation,
    Newline,
    Operator,
    EOF,
};

pub const Token = struct {
    kind: TokenKind,
    lexeme: []const u8,
};

pub fn Lexer() type {
    return struct {
        input: []const u8,
        index: usize,
        indent_level: usize,

        pub fn init(input: []const u8) @This() {
            return .{ .input = input, .index = 0, .indent_level = 0 };
        }

        pub fn nextToken(self: *@This()) Token {
            var current_indent: usize = 0;
            while (self.index < self.input.len) {
                const c = self.input[self.index];
                self.index += 1;

                switch (c) {
                    ' ' => current_indent += 1,
                    '\t' => current_indent += 4,
                    '\n' => {
                        if (current_indent > self.indent_level) {
                            self.indent_level = current_indent;
                            return Token{ .kind = .Indentation, .lexeme = "" };
                        } else if (current_indent < self.indent_level) {
                            self.indent_level = current_indent;
                            return Token{ .kind = .Dedentation, .lexeme = "" };
                        }
                        return Token{ .kind = .Newline, .lexeme = "\n" };
                    },
                    '0'...'9' => {
                        const start = self.index - 1;
                        while (self.index < self.input.len and std.ascii.isDigit(self.input[self.index])) {
                            self.index += 1;
                        }
                        return Token{ .kind = .Number, .lexeme = self.input[start..self.index] };
                    },
                    'a'...'z', 'A'...'Z', '_' => {
                        const start = self.index - 1;
                        while (self.index < self.input.len and (std.ascii.isAlphanumeric(self.input[self.index]) or self.input[self.index] == '_')) {
                            self.index += 1;
                        }
                        const lexeme = self.input[start..self.index];
                        if (std.mem.eql(u8, lexeme, "def") or std.mem.eql(u8, lexeme, "print")) {
                            return Token{ .kind = .Keyword, .lexeme = lexeme };
                        }
                        return Token{ .kind = .Identifier, .lexeme = lexeme };
                    },
                    '"' => {
                        const start = self.index;
                        while (self.index < self.input.len and self.input[self.index] != '"') {
                            self.index += 1;
                        }
                        if (self.index >= self.input.len) {
                            return Token{ .kind = .EOF, .lexeme = "" };
                        }
                        self.index += 1;
                        return Token{ .kind = .String, .lexeme = self.input[start .. self.index - 1] };
                    },
                    '+', '-', '*', '/', '=' => {
                        return Token{ .kind = .Operator, .lexeme = self.input[self.index - 1 .. self.index] };
                    },
                    else => continue,
                }
            }
            return Token{ .kind = .EOF, .lexeme = "" };
        }
    };
}

pub const ASTNode = struct {
    kind: TokenKind,
    value: []const u8,
    children: ?[]ASTNode,
};

pub fn Parser() type {
    return struct {
        tokens: []const Token,
        index: usize,

        pub fn init(tokens: []const Token) @This() {
            return .{ .tokens = tokens, .index = 0 };
        }

        pub fn parse(self: *@This()) ?ASTNode {
            if (self.index >= self.tokens.len) return null;
            const token = self.tokens[self.index];
            self.index += 1;

            switch (token.kind) {
                .Keyword => {
                    if (std.mem.eql(u8, token.lexeme, "def")) {
                        const name = self.tokens[self.index];
                        self.index += 1;
                        return ASTNode{ .kind = .Keyword, .value = name.lexeme, .children = null };
                    }
                },
                .Identifier => {
                    return ASTNode{ .kind = .Identifier, .value = token.lexeme, .children = null };
                },
                .Number => {
                    return ASTNode{ .kind = .Number, .value = token.lexeme, .children = null };
                },
                else => return null,
            }
            return null;
        }
    };
}

pub fn main() !void {
    const source = "let x:int = 12\n";

    var lexer = Lexer().init(source);
    var tokens = std.ArrayList(Token).init(std.heap.page_allocator);
    defer tokens.deinit();

    while (true) {
        const token = lexer.nextToken();
        if (token.kind == .EOF) break;
        try tokens.append(token);
    }

    var parser = Parser().init(tokens.items);
    while (true) {
        const node = parser.parse();
        if (node == null) break;
        std.debug.print("Parsed Node: {s} {s}\n", .{ @tagName(node.?.kind), node.?.value });
    }
}
