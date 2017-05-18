defmodule Cards do

  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Generates a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace","Two","Three","Four","Five"]
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]

    for suit <- suits, value <- values do 
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle deck
  end

  @doc """
    Checks in `deck` which is a list of strings contains a specified `card` 

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Five of Hearts")
      true
      
  """
  def contains?(deck, card) do 
    Enum.member?(deck, card)
  end

  @doc """
    Devides a deck in a hand and a remainder of the deck.
    Takes two arguments the `deck` and `hand_size` which is a number of the size of the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
         
  """
  def deal(deck, hand_size) do
    hand = Enum.split(deck, hand_size)
  end

  def save(deck, filename) do 
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do 
    case File.read(filename) do 
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end


 