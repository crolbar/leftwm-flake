{
  description = "home-manager module for leftwm ";

  outputs = inputs: {
    homeManagerModules = {
      leftwm = import ./module.nix inputs;
      default = inputs.self.homeManagerModules.leftwm;
    };
  };

  inputs.leftwm.url = "github:leftwm/leftwm";
}
