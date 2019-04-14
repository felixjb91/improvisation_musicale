type note_name =
    Do
  | Re
  | Mi
  | Fa
  | Sol
  | La
  | Si

type alteration =
    Becarre
  | Diese

type note = {
  nom: note_name;
  alteration: alteration;
  octave: int;
}

let note_to_midi = ()

let _ =
  let do_4 = { nom = Do; alteration = Becarre; octave = 4; } and 
  do_4_diese = { nom = Do; alteration = Diese; octave = 4; } and 
  la_2 = { nom = La; alteration = Becarre; octave = 2; } and
  la_3 = { nom = La; alteration = Becarre; octave = 3; } and
  la_4 = { nom = La; alteration = Becarre; octave = 4; } and
  mi3 = { nom = Mi; alteration = Becarre; octave = 3; }
  in ()