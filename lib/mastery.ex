defmodule Mastery do
  alias Mastery.Boundary.{QuizSession, QuizManager}
  alias Mastery.Boundary.{TemplateValidator, QuizValidator}
  alias Mastery.Core.Quiz

  @persistence_fn Application.get_env(:mastery, :persistence_fn)

  def build_quiz(fields) do
    with :ok <- QuizValidator.errors(fields),
         :ok <- GenServer.call(QuizManager, {:build_quiz, fields}),
         do: :ok,
         else: (error -> error)
  end

  def take_quiz(title, email) do
    with %Quiz{} = quiz <- QuizManager.lookup_quiz_by_title(title),
         {:ok, _} <- GenServer.start_link(QuizSession, {quiz, email}) do
      {title, email}
    else
      error -> error
    end
  end

  def select_question(session) do
    GenServer.call(session, :select_question)
  end

  def answer_question(session, answer) do
    GenServer.call(session, {:answer_question, answer})
  end

  def answer_question(name, answer, persistence_fn \\ @persistence_fn) do
    QuizSession.answer_question(name, answer, persistence_fn)
  end
end
