defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string), do:
    string
    |> String.split()
    |> gather_first_letter_and_capitals()
    |> Enum.join()
    |> String.upcase()

  defp gather_first_letter_and_capitals(strings) when is_list(strings), do:
    strings
    |> Enum.map(&gather_first_letter_and_capitals/1)
    |> Enum.concat

  # ^.{0,1}   Grab 1 (any) char, anchored to the beginning of the string
  # |         And also
  # [A-Z]+    One or more occurrences of any character between A and Z
  defp gather_first_letter_and_capitals(string) when is_bitstring(string), do:
    Regex.scan(~r/^.{0,1}|[A-Z]+/, string)

end
