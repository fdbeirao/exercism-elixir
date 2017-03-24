defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(string, size) do
    case size < 1 or size > String.length(string) do
      true -> []
      _otherwise -> slices?(string, size)
    end
  end

  defp slices?(string, size),do:
    String.length(string)
    |> string_ranges(size)
    |> Enum.map(&slice(&1, string))

  @doc """
  Example:

  iex> StringSeries.string_ranges(total_chars: 4, window_size: 2)
  [0..2, 1..3, 2..4, 3..5, 4..6]
  """
  def string_ranges(total_chars, window_size), do:
    for start <- 0..(total_chars - window_size), do: 
      start..(start + window_size - 1)

  defp slice(range, string), do:
    String.slice(string, range)
end

