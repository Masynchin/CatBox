{ name = "cat-box"
, dependencies =
  [ "console"
  , "control"
  , "effect"
  , "either"
  , "flame"
  , "foldable-traversable"
  , "lists"
  , "parsing"
  , "prelude"
  , "test-unit"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
