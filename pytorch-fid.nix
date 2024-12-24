{
  lib,
  pythonRelaxDepsHook,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  numpy,
  pillow,
  scipy,
  torch,
  torchvision,
}:

buildPythonPackage rec {
  pname = "pytorch-fid";
  version = "master";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mseitzer";
    repo = "pytorch-fid";
    rev = version;
    hash = "sha256-L/Ka+p1Fl/Lge1V/ry6gqS5iswAKnfxggiMI446Gtlw=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    numpy
    pillow
    scipy
    torch
    torchvision
  ];

  nativeBuildInputs = [ pythonRelaxDepsHook ];
  pythonRelaxDeps = [ "torch" ];

  pythonImportsCheck = [
    "pytorch_fid"
  ];

  meta = {
    description = "Compute FID scores with PyTorch";
    homepage = "https://github.com/mseitzer/pytorch-fid";
    changelog = "https://github.com/mseitzer/pytorch-fid/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
