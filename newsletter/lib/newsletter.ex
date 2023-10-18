defmodule Newsletter do
  def read_emails(path) do
    case File.read(path) do
      {:ok, content} -> content |> String.split("\n") |> Enum.reverse() |> tl() |> Enum.reverse()
      _ -> []
    end
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, "#{email}")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log_pid = open_log(log_path)
    emails = read_emails(emails_path)

    for email <- emails do
      case send_fun.(email) do
        :ok -> log_sent_email(log_pid, email)
        _ -> :error
      end
    end

    close_log(log_pid)
  end
end
