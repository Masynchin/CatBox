{ name = "cat-box"
, dependencies =
  [ "arrays"
  , "console"
  , "control"
  , "effect"
  , "either"
  , "flame"
  , "foldable-traversable"
  , "lists"
  , "maybe"
  , "parsing"
  , "prelude"
  , "test-unit"
  , "tuples"
  , "web-events"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
