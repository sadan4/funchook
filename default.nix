{
  stdenv,
  # Release, Debug, RelWithDebInfo, MinSizeRel
  buildType ? "Release",
  cmake,
  gnumake,
  zydis,
  callPackage,
  fetchFromGitHub,
}:
stdenv.mkDerivation (
  finalAttrs:
  let
    zydisSrc = fetchFromGitHub {
      owner = "zyantific";
      repo = "zydis";
      rev = "v4.1.0";
      hash = "sha256-akusu0T7q5RX4KGtjRqqOFpW5i9Bd1L4RVZt8Rg3PJY=";
    };
  in
  rec {
    pname = "funchook";
    name = pname;
    src = ./.;
    buildInputs = [
      # (capstone.overrideAttrs (
      #   _: old: {
      #     src = fetchFromGitHub {
      #       owner = "capstone-engine";
      #       repo = "capstone";
      #       rev = "097c04d9413c59a58b00d4d1c8d5dc0ac158ffaa";
      #       hash = "sha256-kKmL5sae9ruWGu1gas1mel9qM52qQOD+zLj8cRE3isg";
      #     };
      #   }
      # ))
      zydis
      # wont build outside of this repo without this
      # reproducible builds my ass
      (callPackage (import ./zycore.nix) { })
    ];
    nativeBuildInputs = [
      cmake
      gnumake
      zydis
    ];
    configurePhase = ''
      runHook preConfigure

      mkdir build
      pushd build
      export ZYDIS_SRC=${zydisSrc}
      cmake -DCMAKE_BUILD_TYPE=${buildType} -DFUNCHOOK_DISASM=zydis ..
      popd

      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild

      pushd build
      make -j
      popd

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/include $out/lib
      cp -r include/* $out/include
      cp build/libfunc* $out/lib

      runHook postInstall
    '';
  }
)
