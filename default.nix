{
  stdenv,
  # Release, Debug, RelWithDebInfo, MinSizeRel
  buildType ? "Release",
  cmake,
  gnumake,
  capstone,
  git
}:
stdenv.mkDerivation (finalAttrs: rec {
  pname = "funchook";
  name = pname;
  src = ./.;
  buildInputs = [
    capstone
  ];
  nativeBuildInputs = [
    cmake
    gnumake
    git
  ];
  configurePhase = ''
    runHook preConfigure

    mkdir build
    pushd build
    export CAPSTONE_DIR=${capstone}
    cmake -DCMAKE_BUILD_TYPE=${buildType} -DFUNCHOOK_DISASM=capstone ..
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

    ls -alh build
    mkdir -p $out/include $out/lib
    cp -r include/* $out/include
    cp build/libfunc* $out/lib

    runHook postInstall
    '';
})
