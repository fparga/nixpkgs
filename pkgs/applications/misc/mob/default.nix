{ lib
, buildGoPackage
, fetchFromGitHub

, withSpeech ? true
, makeWrapper
, espeak-ng
}:

buildGoPackage rec {
  pname = "mob";
  version = "2.2.0";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "remotemobprogramming";
    repo = pname;
    sha256 = "sha256-nf0FSaUi8qX1f4Luo0cP4ZLoOKbyvgmpilMOWXbzzIM=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  goPackagePath = "github.com/remotemobprogramming/mob";

  preFixup = lib.optionalString withSpeech ''
    wrapProgram $out/bin/mob \
      --set MOB_VOICE_COMMAND "${lib.getBin espeak-ng}/bin/espeak"
  '';

  meta = with lib; {
    description = "Tool for smooth git handover";
    homepage = "https://github.com/remotemobprogramming/mob";
    license = licenses.mit;
    maintainers = with maintainers; [ ericdallo ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
