{
  typescript = {
    "Effect Generator Function" = {
      description = "Scaffolds an Effect generator function";
      prefix = "gg";
      body = [
        "Effect.gen(function*() {"
        "  $0"
        "})"
      ];
    };
    "Effect Generator Yield Statement" = {
      description = "Scaffolds an Effect generator yield* statement";
      prefix = "yy";
      body = ["yield* $0"];
    };
  };
  typescriptreact = {
    "React Function Component" = {
      description = "Scaffolds a React functional component";
      prefix = "rfc";
      body = [
        "import React from \"react\""
        ""
        "export declare namespace $1 {"
        "  export interface Props {"
        "    $2"
        "  }"
        "}"
        ""
        "export const $1: React.FC<$1.Props> = ({}) => {"
        "  $0"
        "}"
        ""
        "$1.displayName = \"$1\""
      ];
    };
  };
}
