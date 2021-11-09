defmodule PhoenixChatLive.TranslateTask do
  # alias PhoenixChatLive.Repo

  require Logger

  alias PhoenixChatLive.Messages

  def translate(%{text: text} = message) do
    body = %GoogleApi.Translate.V2.Model.TranslateTextRequest{
      format: "text",
      model: "nmt",
      q: text,
      target: "ru"
    }

    with {:ok, token} <- Goth.fetch(PhoenixChatLive.Goth),
         %Tesla.Client{} = conn <- GoogleApi.Translate.V2.Connection.new(token.token),
         {:ok, resp} <- GoogleApi.Translate.V2.Api.Translations.language_translations_translate(conn, body: body) do
      [%{translatedText: translatedText} | _] = resp.translations

      Messages.update_message(message, %{text: translatedText})
    else
      error ->
        Logger.error("Translate error #{inspect(error)}")
        error
    end
  end
end
