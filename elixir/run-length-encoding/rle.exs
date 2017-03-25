defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string), do:
    Regex.scan(~r/(.)\1*/, string) # "AAaBCCAADDDE" -> [["AA", "A"], ["a", "a"], ["B", "B"], ["CC", "C"], ["AA", "A"], ["DDD", "D"], ["E", "E"]]
    |> Enum.map(&group_by_length/1)
    |> Enum.map(&group_to_string/1)
    |> Enum.join

  @spec decode(String.t) :: String.t
  def decode(string), do:
    Regex.scan(~r/\d+[A-Z ]|[A-Z ]/i, string) # "22A3B 4c5 DE5F" -> [["22A"], ["3B"], [" "], ["4c"], ["5 "], ["D"], ["E"], ["5F"]]
    |> Enum.concat # ["22A", "3B", " ", "4c", "5 ", "D", "E", "5F"]
    |> Enum.map(&extract_repetitions/1)
    |> Enum.map(&repeat_string/1)
    |> Enum.join

  defp group_by_length([chars, char]), do:
    { String.length(chars), char }

  defp group_to_string({1, char}), do: char
  defp group_to_string({times, char}), do: "#{times}#{char}"

  defp extract_repetitions(string) do
    case Regex.run(~r/(\d+)([A-Z ])|[A-Z ]/i, string) do # "22A" -> [["22A", "22", "A"]] || "D" -> [["D"]]
      [_, repetitions, char] -> 
        { parsed_repetitions, _ } = Integer.parse(repetitions)
        { parsed_repetitions, char }
      [char] -> 
        {1, char}
    end
  end

  defp repeat_string({times, string}), do:
    String.duplicate(string, times)
end
