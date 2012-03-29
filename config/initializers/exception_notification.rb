Upcoming::Application.config.middleware.use ExceptionNotifier,
  email_prefix:         "[Upcoming] ",
  sender_address:       %{"Upcoming" <upcoming@anticlever.com>},
  exception_recipients: %{alex@anticlever.com}
