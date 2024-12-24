{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  torch,
}:

buildPythonPackage rec {
  pname = "prodigy";
  version = "1.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "konstmish";
    repo = "prodigy";
    rev = "v${version}";
    hash = "sha256-FEW/UH3Kb0NJAzFWBRvtfx1bD4IpniHDblyDS0qQYF8=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    torch
  ];

  pythonImportsCheck = [
    "prodigyopt"
  ];

  meta = {
    description = "The Prodigy optimizer and its variants for training neural networks";
    homepage = "https://github.com/konstmish/prodigy";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
