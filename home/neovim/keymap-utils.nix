let
  mkKeymap = {
    mode,
    key,
    action,
    desc,
    opts ? {},
  }: {
    inherit mode key action;
    options =
      {
        inherit desc;
        silent = true;
        noremap = true;
      }
      // opts;
  };
in {
  map = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "";
    };

  nmap = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "n";
      opts = {noremap = false;};
    };

  nnoremap = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "n";
    };

  vnoremap = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "v";
    };

  xnoremap = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "x";
    };

  inoremap = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "i";
    };

  tnoremap = key: action: desc:
    mkKeymap {
      inherit key action desc;
      mode = "t";
    };
}
