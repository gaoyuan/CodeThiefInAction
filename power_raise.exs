defmodule Power do
  defmacro raise_n(x) do 
    method_name = :"raise_#{x}"
    quote do
      def unquote(method_name)(val) do
        :math.pow(val, unquote(x) )
      end
    end
  end
end


defmodule Test do
  require Power
    Power.raise_n(3)
    Power.raise_n(4)
    Power.raise_n(2)
end



IO.puts Test.raise_4(5)
IO.puts Test.raise_3(3)
IO.puts Test.raise_2(4)
