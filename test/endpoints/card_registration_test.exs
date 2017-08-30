defmodule Iyzico.CardRegistrationTest do
  use Iyzico.EndpointCase

  import Iyzico.CardRegistration

  alias Iyzico.Card
  alias Iyzico.CardReference

  test "registers a card" do
    card =
      %Card{
        holder_name: "Abdulkadir Dilsiz",
        number: "5528790000000008",
        exp_year: 19,
        exp_month: 08,
        cvc: 543,
        registration_alias: "Kadir's credit card"
      }

    {:ok, card, metadata} =
      create_card(card, "external_id", "conversation_id", "test@mail.com")

    assert metadata.succeed?
  end

  test "retrieves cards of a user" do
    {:ok, cards, metadata} =
      retrieve_cards("8Fji9iMAKOuIKYX7OtlfGP3MqHc=", "123456789")

    assert metadata.succeed?
  end

  test "deletes a card of a user" do
    card =
      %Card{
        holder_name: "Abdulkadir Dilsiz",
        number: "5528790000000008",
        exp_year: 19,
        exp_month: 08,
        cvc: 543,
        registration_alias: "Kadir's credit card"
      }

    {:ok, card, metadata} =
      create_card(card, "external_id", "conversation_id", "test@mail.com")

    {:ok, metadata} =
      delete_card(card.user_key, card.token, "123456789")
  end
end
