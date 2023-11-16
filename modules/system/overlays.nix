self: super: {
  awesome-git = super.awesome.overrideAttrs (old: {
    pname = "awesome-git";
    src = super.fetchFromGitHub {
      owner = "awesomeWM";
      repo = "awesome";
      rev = "e26069682635b734d61c251e261d8fcadcd7522c";
      sha256 = "sha256-hrnDRSUbrfDa+84vSrahlFY7Tag+rcSyNUUmZRzwyZw=";
    };
  });
}
