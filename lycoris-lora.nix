{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  einops,
  toml,
  torch,
  safetensors,
}:

buildPythonPackage rec {
  pname = "ly-coris";
  version = "unstable-2024-12-09";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "KohakuBlueleaf";
    repo = "LyCORIS";
    rev = "0538b17fe30acd27900a8efe829fdfb6f5016430";
    hash = "sha256-2pL+6tLk1Xgrus+I5a2ZkJDLcwMNZYW2isBM2stT15Y=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    einops
    toml
    torch
    safetensors
  ];

  pythonImportsCheck = [
    "lycoris"
  ];

  meta = {
    description = "Lora beYond Conventional methods, Other Rank adaptation Implementations for Stable diffusion";
    homepage = "https://github.com/KohakuBlueleaf/LyCORIS";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
