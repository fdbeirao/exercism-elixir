defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom(),  list(String.t()) }
  def of_rna(rna) do
    proteins = rna # "AUGUUU"
    |> String.graphemes # ["A", "U", "G", "U", "U", "U"]
    |> Enum.chunk(3) # [["A", "U", "G"], ["U", "U", "U"]]
    |> Enum.map(fn chunk -> of_codon?(to_string(chunk)) end) # [{:ok, "Methionine"}, {:ok, "Phenylalanine"}]
    |> Enum.reduce_while([], fn
      { :ok, "STOP" }, acc   -> { :halt, acc }
      { :ok, protein }, acc  -> { :cont, [protein | acc] }
      { :error, _ } = err, _ -> { :halt, err }
    end) # [ "Phenylalanine", "Methionine" ]
    
    case proteins do
      proteins? when is_list(proteins?) -> { :ok, Enum.reverse(proteins?) }
      _ -> { :error, "invalid RNA" }
    end
  end

  @spec of_codon(String.t()) :: { atom(), String.t() }
  def of_codon(codon), do:
    of_codon?(codon)

  defp of_codon?(codon) when codon in ["AUG"], do: 
    success "Methionine"
  defp of_codon?(codon) when codon in ["UUU", "UUC"], do: 
    success "Phenylalanine"
  defp of_codon?(codon) when codon in ["UUA", "UUG"], do: 
    success "Leucine"
  defp of_codon?(codon) when codon in ["UCU", "UCC", "UCA", "UCG"], do: 
    success "Serine"
  defp of_codon?(codon) when codon in ["UAU", "UAC"], do: 
    success "Tyrosine"
  defp of_codon?(codon) when codon in ["UGU", "UGC"], do: 
    success "Cysteine"
  defp of_codon?(codon) when codon in ["UGG"], do: 
    success "Tryptophan"
  defp of_codon?(codon) when codon in ["UAA", "UAG", "UGA"], do: 
    success "STOP"
  defp of_codon?(_), do: 
    error "invalid codon"

  defp success(value), do: 
    { :ok, value }

  defp error(reason), do: 
    { :error, reason }
end
