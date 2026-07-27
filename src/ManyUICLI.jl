module ManyUICLI

using Comonicon
using ManyUI

export @project_cli

"""
    @project_cli model begin
        Action1(arg1::Type1)
        Action2()
    end

Generates `Comonicon.@cast` functions for each action signature in the block.
When invoked from the CLI, the function creates the Action and calls `ManyUI.execute!(model, action)`.
"""
macro project_cli(model, block)
    if !(block isa Expr && block.head == :block)
        error("Expected a block of action signatures (e.g., `begin Save(file::String) end`)")
    end
    
    exprs = []
    for stmt in block.args
        if stmt isa LineNumberNode
            push!(exprs, stmt)
            continue
        end
        
        if !(stmt isa Expr && stmt.head == :call)
            error("Expected an action signature like Save(file::String), got: $stmt")
        end
        
        action_name = stmt.args[1]
        func_name = Symbol(lowercase(String(action_name)))
        
        func_args = stmt.args[2:end]
        
        arg_names = map(func_args) do arg
            if arg isa Expr && arg.head == :(::)
                return arg.args[1]
            elseif arg isa Symbol
                return arg
            elseif arg isa Expr && arg.head == :kw
                left = arg.args[1]
                if left isa Expr && left.head == :(::)
                    return left.args[1]
                else
                    return left
                end
            else
                error("Unsupported argument format: $arg")
            end
        end
        
        func_expr = quote
            Comonicon.@cast function $func_name($(func_args...))
                ManyUI.execute!($model, $action_name($(arg_names...)))
            end
        end
        
        push!(exprs, func_expr)
    end
    
    return esc(quote
        $(exprs...)
    end)
end

end # module ManyUICLI
