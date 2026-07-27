# ManyUICLI.jl

A bridge package for `ManyUI` that automatically transforms a `ManyUI.Widget` tree into a CLI interface using `Comonicon.jl`.

## Features
- Generates command-line arguments and flags dynamically based on the declarative UI model.
- Extends the `ManyUI` philosophy: build your domain model once and expose it as a Terminal UI, a Web App, or a CLI instantly.
- Uses `Comonicon` `@cast` and `@main` macros for rapid parsing.
