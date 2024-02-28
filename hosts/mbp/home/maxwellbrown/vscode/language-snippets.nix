{
  typescript = {
    "Gen Function _" = {
      description = "Generator Function with a _ parameter";
      prefix = "gg";
      body = [
        "Effect.gen(function*(_) {"
        "  $0"
        "})"
      ];
    };
    "Gen Yield _" = {
      prefix = "yy";
      body = [
        "yield* _($0)"
      ];
      description = "Yield generator calling _()";
    };
  };
}
