{ lib
, beautifulsoup4
, blinker
, buildPythonPackage
, docutils
, feedgenerator
, fetchFromGitHub
, git
, glibcLocales
, jinja2
, lxml
, markdown
, markupsafe
, mock
, ordered-set
, pandoc
, pdm-backend
, pillow
, pygments
, pytest-xdist
, pytestCheckHook
, python-dateutil
, pythonOlder
, pytz
, rich
, six
, typogrify
, unidecode
, watchfiles
}:

buildPythonPackage rec {
  pname = "pelican";
  version = "4.9.1";
  disabled = pythonOlder "3.8";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "getpelican";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-nz2OnxJ4mGgnafz4Xp8K/BTyVgXNpNYqteNL1owP8Hk=";
    # Remove unicode file names which leads to different checksums on HFS+
    # vs. other filesystems because of unicode normalisation.
    postFetch = ''
      rm -r $out/pelican/tests/output/custom_locale/posts
    '';
  };

  buildInputs = [
    pdm-backend
    glibcLocales
    pandoc
    git
    mock
    markdown
    typogrify
  ];

  propagatedBuildInputs = [
    beautifulsoup4
    blinker
    docutils
    feedgenerator
    jinja2
    lxml
    markupsafe
    ordered-set
    pillow
    pygments
    python-dateutil
    pytz
    rich
    six
    unidecode
    watchfiles
  ];

  nativeCheckInputs = [
    pytest-xdist
    pytestCheckHook
    pandoc
    git
  ];

  disabledTests = [
    # AssertionError
    "test_blinker_is_ordered"
    "test_custom_locale_generation_works"
  ];

  LC_ALL = "en_US.UTF-8";

  # We only want to patch shebangs in /bin, and not those
  # of the project scripts that are created by Pelican.
  # See https://github.com/NixOS/nixpkgs/issues/30116
  dontPatchShebangs = true;

  postFixup = ''
    patchShebangs $out/bin
  '';

  pythonImportsCheck = [ "pelican" ];

  meta = with lib; {
    description = "Static site generator that requires no database or server-side logic";
    homepage = "https://getpelican.com/";
    license = licenses.agpl3;
    maintainers = with maintainers; [ offline prikhi ];
  };
}
