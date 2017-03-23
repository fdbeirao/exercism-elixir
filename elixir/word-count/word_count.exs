defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence), do:
    sentence
    |> String.downcase
    |> split
    |> Enum.group_by(&identity/1)
    |> Enum.into(%{}, &using_occurrences_as_value/1)

  defp split(input), do:
    Regex.scan(~r/[\p{L}\d-]+/u, input)
    |> Enum.concat
  
  defp identity(item), do: item

  defp using_occurrences_as_value({word, occurences}), do:
    { word, length(occurences) }
end
