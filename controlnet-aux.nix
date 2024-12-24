{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, filelock
, huggingface-hub
, opencv-python
, torchvision
, einops
, scikit-image
, timm
, pythonRelaxDepsHook
, importlib-metadata
}:

buildPythonPackage rec {
  pname = "controlnet-aux";
  version = "0.0.9";
  format = "pyproject";

  src = fetchPypi {
    pname = "controlnet_aux";
    inherit version;
    hash = "sha256-bCg1Lm/pszJNaxKI2U0cJYbG4vyfWN+eRyl+pqhv1WA=";
  };

  propagatedBuildInputs = [
    filelock
    huggingface-hub
    opencv-python
    torchvision
    einops
    scikit-image
    timm

    importlib-metadata
  ];

  pythonRelaxDeps = [ "timm" ];

  nativeBuildInputs = [
    setuptools
    wheel
    pythonRelaxDepsHook
  ];

  pythonImportsCheck = [ "controlnet_aux" ];
  pythonRemoveDeps = [ "opencv-python" ];

  meta = with lib; {
    description = "Auxillary models for controlnet";
    homepage = "https://pypi.org/project/controlnet-aux/";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
