{pkgs, ...}: {
  # Breadcrumbs Settings
  "breadcrumbs.enabled" = true;
  # Editor Settings
  "editor.codeActionsOnSave" = {
    "source.fixAll.eslint" = "always";
    "source.fixAll.shellcheck" = "always";
  };
  "editor.cursorBlinking" = "solid";
  "editor.cursorWidth" = 3;
  "editor.cursorSurroundingLines" = 10;
  "editor.fontFamily" = "Hack Nerd Font Mono";
  "editor.fontSize" = 14;
  "editor.formatOnSave" = false;
  "editor.inlineSuggest.enabled" = true;
  "editor.multiCursorModifier" = "ctrlCmd";
  "editor.minimap.enabled" = false;
  "editor.acceptSuggestionOnCommitCharacter" = true;
  "editor.acceptSuggestionOnEnter" = "on";
  "editor.suggestOnTriggerCharacters" = true;
  "editor.tabCompletion" = "off";
  "editor.suggest.localityBonus" = true;
  "editor.quickSuggestions" = {
    "other" = true;
    "comments" = false;
    "strings" = false;
  };
  "editor.quickSuggestionsDelay" = 10;
  "editor.rulers" = [80 100];
  "editor.suggestSelection" = "first";
  "editor.tabSize" = 2;
  "editor.wordBasedSuggestions" = "matchingDocuments";
  "editor.wordWrap" = "on";
  # Explorer Settings
  "explorer.confirmDragAndDrop" = false;
  "explorer.compactFolders" = false;
  # Extension Settings
  "extensions.ignoreRecommendations" = false;
  "extensions.experimental.affinity" = {
    "vscodevim.vim" = 1;
  };
  # File Settings
  "files.autoSave" = "afterDelay";
  "files.autoSaveDelay" = 1000;
  "files.watcherExclude" = {
    "**/.bloop" = true;
    "**/.metals" = true;
    "**/.ammonite" = true;
  };
  "files.exclude" = {
    "**/.classpath" = true;
    "**/.project" = true;
    "**/.settings" = true;
    "**/.factorypath" = true;
  };
  "files.trimTrailingWhitespace" = true;
  # Terminal Settings
  "terminal.integrated.fontFamily" = "Hack Nerd Font Mono";
  "terminal.integrated.fontSize" = 14;
  "terminal.integrated.shellIntegration.enabled" = true;
  # Window Settings
  "window.title" = "\${dirty} \${activeEditorMedium}\${separator}\${rootName}";
  "workbench.editor.tabSizing" = "shrink";
  "workbench.colorTheme" = "Atom One Dark";
  "workbench.iconTheme" = "vscode-icons";
  "workbench.startupEditor" = "newUntitledFile";
  # Emmet Settings
  "emmet.includeLanguages" = {
    "javascript" = "javascriptreact";
  };
  "emmet.showExpandedAbbreviation" = "never";
  "emmet.syntaxProfiles" = {
    "javascript" = "jsx";
  };
  "emmet.triggerExpansionOnTab" = true;
  # Eslint Settings
  "eslint.alwaysShowStatus" = true;
  "eslint.options" = {
    "extensions" = [".js" ".jsx" ".md" ".mdx" ".ts" ".tsx"];
  };
  "eslint.validate" = [
    "javascript"
    "javascriptreact"
    "markdown"
    "mdx"
    "typescript"
    "typescriptreact"
  ];
  # JavaScript Settings
  "javascript.updateImportsOnFileMove.enabled" = "never";
  # MDX Settings
  "mdx.experimentalLanguageServer" = true;
  # Jupyter Notebook Settings
  "notebook.cellToolbarLocation" = {
    "default" = "right";
    "jupyter-notebook" = "left";
  };
  # Nix Settings
  # Try again after https://github.com/nix-community/nixd/issues/107 resolved
  # "nix.enableLanguageServer" = true;
  # "nix.serverPath" = "nixd";
  # "nix.formatterPath" = "nixpkgs-fmt";
  "nix.enableLanguageServer" = true;
  "nix.formatterPath" = ["nix" "fmt" "--" "-"];
  "nix.serverPath" = "${pkgs.nil}/bin/nil";
  "nix.serverSettings" = {
    "nil" = {
      "diagnostics" = {
        "ignored" = ["unused_binding" "unused_with"];
      };
      "formatting" = {
        "command" = ["alejandra"];
      };
    };
  };
  # Direnv Settings
  "direnv.path.executable" = "${pkgs.direnv}/bin/direnv";
  # Python Settings
  "python.analysis.typeCheckingMode" = "basic";
  "python.formatting.provider" = "black";
  "python.linting.flake8Enabled" = false;
  "python.linting.enabled" = true;
  "python.insidersChannel" = "weekly";
  "ruff.importStrategy" = "fromEnvironment";
  # Shellcheck Settings
  "shellcheck.customArgs" = ["--external-sources"];
  "shellformat.effectLanguages" = [
    "shellscript"
    "dotenv"
    "hosts"
    "jvmoptions"
    "ignore"
    "gitignore"
    "properties"
    "spring-boot-properties"
    "azcli"
  ];
  "shellcheck.exclude" = ["SC2155"];
  "shellcheck.useWorkspaceRootAsCwd" = true;
  # TypeScript Settings
  "typescript.tsserver.log" = "off";
  "typescript.updateImportsOnFileMove.enabled" = "never";
  "typescript.tsdk" = "./node_modules/typescript/lib";
  # Vim Settings
  "vim.easymotion" = true;
  "vim.hlsearch" = true;
  "vim.incsearch" = true;
  "vim.useSystemClipboard" = true;
  "vim.useCtrlKeys" = true;
  "vim.surround" = true;
  "vim.insertModeKeyBindings" = [
    {
      "before" = ["j" "j"];
      "after" = ["<Esc>"];
    }
  ];
  "vim.normalModeKeyBindingsNonRecursive" = [
    {
      "before" = ["<leader>" "d"];
      "after" = ["d" "d"];
    }
    {
      "before" = ["<C-n>"];
      "commands" = [":nohl"];
    }
  ];
  "vim.leader" = "<space>";
  "vim.handleKeys" = {
    "<C-a>" = false;
    "<C-f>" = false;
  };
  # LANGUAGE SETTINGS
  "[csharp]" = {
    "editor.tabSize" = 4;
  };
  "[dockerfile]" = {
    "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
    "editor.formatOnSave" = true;
  };
  "[html]" = {
    "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
  };
  "[javascript]" = {
    "editor.formatOnSave" = true;
  };
  "[javascriptreact]" = {
    "editor.formatOnSave" = true;
  };
  "[json]" = {
    "editor.defaultFormatter" = "vscode.json-language-features";
  };
  "[jsonc]" = {
    "editor.defaultFormatter" = "vscode.json-language-features";
  };
  "[markdown]" = {
    "editor.formatOnSave" = true;
    "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
  };
  "[mdx]" = {
    "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
    "editor.formatOnSave" = true;
  };
  "[nix]" = {
    "editor.formatOnSave" = true;
  };
  "[python]" = {
    "editor.formatOnSave" = true;
    "editor.tabSize" = 4;
  };
  "[rust]" = {
    "editor.formatOnSave" = true;
  };
  "[typescript]" = {
    "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
  };
  "[yaml]" = {
    "editor.tabSize" = 2;
    "editor.formatOnSave" = true;
  };
  # Miscellaneous Settings
  "diffEditor.ignoreTrimWhitespace" = false;
  "vsicons.dontShowNewVersionMessage" = true;
}
