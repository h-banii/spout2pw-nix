{
  description = "flake with spout2pw related packages";

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs (import systems);
      pkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = self.packages.${system}.spout2pw-bin;
          # spout2pw = pkgs.callPackage ./pkgs/spout2pw { }; # TODO: fix?
          spout2pw-bin = pkgs.callPackage ./pkgs/spout2pw-bin { };
          obs-pwvideo = pkgs.callPackage ./pkgs/obs-pwvideo { };
        }
      );
    };
}
