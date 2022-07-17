{ name = "cat-box"
, dependencies =
  [ "console"
  , "effect"
  , "foldable-traversable"
  , "lists"
  , "prelude"
  , "test-unit"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
