{
  description = "Description for the project";

  nixConfig = {
    extra-trusted-substituters = [
      "https://ai.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-substituters = [
      "https://ai.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/d3c42f187194c26d9f0309a8ecc469d6c878ce33";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
          config.cudaSupport = true;
          inherit system;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs.python3Packages; [
            torch
            torchvision
            safetensors
            diffusers
            transformers
            (pkgs.python3Packages.callPackage ./lycoris-lora.nix {})
            flatten-json
            pyyaml
            oyaml
            tensorboard
            kornia
            invisible-watermark
            einops
            accelerate
            toml
            albumentations
            albucore
            pydantic
            omegaconf
            k-diffusion
            open-clip-torch
            timm
            (pkgs.python3Packages.callPackage ./prodigyopt.nix {})
            (pkgs.python3Packages.callPackage ./controlnet-aux.nix {})
            python-dotenv
            bitsandbytes
            hf-transfer
            (pkgs.python3Packages.callPackage ./lpips.nix {})
            (pkgs.python3Packages.callPackage ./pytorch-fid.nix {})
            # optimum-quanto
            sentencepiece
            huggingface-hub
            peft
            gradio
            python-slugify            
          ];
        };
      };
      flake = {
      };
    };
}
