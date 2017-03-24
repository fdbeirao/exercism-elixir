defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun), do:
    accumulate!(list, fun, [])
  
  defp accumulate!([], _, acc), do: 
    reverse(acc)
  defp accumulate!([head|tail], fun, acc), do:
    accumulate!(tail, fun, [fun.(head)|acc])

  defp reverse(list), do:
    reverse!(list, [])

  defp reverse!([], acc), do:
    acc
  defp reverse!([head|tail], acc), do:
    reverse!(tail, [head|acc])

end
