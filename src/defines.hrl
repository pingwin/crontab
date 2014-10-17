%%%%
%% These were taken from stdlib2 in order to remove the stdlib2 dependancy.
%% In order that crontab plays well with R17 and dialyzer.
%%%%

-ifndef(__CRONTAB_DEFINES_HRL).
-define(__CRONTAB_DEFINES_HRL, true).

-type whynot(B) :: ok | {error, B}.

-ifdef(S2_USE_LAGER).

-compile([{parse_transform, lager_transform}]).

-define(debug(Format),           lager:debug(Format, [])).
-define(debug(Format, Args),     lager:debug(Format, Args)).
-define(info(Format),            lager:info(Format, [])).
-define(info(Format, Args),      lager:info(Format, Args)).
-define(notice(Format),          lager:notice(Format, [])).
-define(notice(Format, Args),    lager:notice(Format, Args)).
-define(warning(Format),         lager:warning(Format, [])).
-define(warning(Format, Args),   lager:warning(Format, Args)).
-define(error(Format),           lager:error(Format, [])).
-define(error(Format, Args),     lager:error(Format, Args)).
-define(critical(Format),        lager:critical(Format, [])).
-define(critical(Format, Args),  lager:critical(Format, Args)).
-define(alert(Format),           lager:alert(Format, [])).
-define(alert(Format, Args),     lager:alert(Format, Args)).
-define(emergency(Format),       lager:emergency(Format, [])).
-define(emergency(Format, Args), lager:emergency(Format, Args)).

-else.

-ifdef(S2_DEBUG).
-define(debug(Msg),            ?debug(Msg, [])).
-define(debug(Fmt, As),        ?do_debug("~p:~s:~p: Debug: " Fmt "~n",
                                         [self(), ?FILE, ?LINE|As])).
-else.
-define(debug(Msg),            ok).
-define(debug(Fmt, As),        ok).
-endif. %S2_DEBUG

-define(info(Msg),             ?info(Msg, [])).
-define(info(Fmt, As),         ?do_info("~p:~s:~p: Info: " Fmt "~n",
                                        [self(), ?FILE, ?LINE|As])).
-define(notice(Msg),           ?notice(Msg, [])).
-define(notice(Fmt, As),       ?do_notice("~p:~s:~p: Notice: " Fmt "~n",
                                          [self(), ?FILE, ?LINE|As])).
-define(warning(Msg),          ?warning(Msg, [])).
-define(warning(Fmt, As),      ?do_warning("~p:~s:~p: Warning: " Fmt "~n",
                                           [self(), ?FILE, ?LINE|As])).
-define(error(Msg),            ?error(Msg, [])).
-define(error(Fmt, As),        ?do_error("~p:~s:~p: Error: " Fmt "~n",
                                         [self(), ?FILE, ?LINE|As])).
-define(critical(Msg),         ?critical(Msg, [])).
-define(critical(Fmt, As),     ?do_critical("~p:~s:~p: Critical: " Fmt "~n",
                                            [self(), ?FILE, ?LINE|As])).
-define(alert(Msg),            ?alert(Msg, [])).
-define(alert(Fmt, As),        ?do_alert("~p:~s:~p: Alert: " Fmt "~n",
                                         [self(), ?FILE, ?LINE|As])).
-define(emergency(Msg),        ?emergency(Msg, [])).
-define(emergency(Fmt, As),    ?do_emergency("~p:~s:~p: Emergency: " Fmt "~n",
                                             [self(), ?FILE, ?LINE|As])).

-ifdef(S2_NOLOG).

-define(do_debug(Fmt, As),     ok).
-define(do_info(Fmt, As),      ok).
-define(do_notice(Fmt, As),    ok).
-define(do_warning(Fmt, As),   ok).
-define(do_error(Fmt, As),     ok).
-define(do_critical(Fmt, As),  ok).
-define(do_alert(Fmt, As),     ok).
-define(do_emergency(Fmt, As), ok).

-else. %default

-define(do_debug(Fmt, As),     error_logger:info_msg(Fmt, As)).
-define(do_info(Fmt, As),      error_logger:info_msg(Fmt, As)).
-define(do_notice(Fmt, As),    error_logger:info_msg(Fmt, As)).
-define(do_warning(Fmt, As),   error_logger:warning_msg(Fmt, As)).
-define(do_error(Fmt, As),     error_logger:warning_msg(Fmt, As)).
-define(do_critical(Fmt, As),  error_logger:error_msg(Fmt, As)).
-define(do_alert(Fmt, As),     error_logger:error_msg(Fmt, As)).
-define(do_emergency(Fmt, As), error_logger:error_msg(Fmt, As)).

-endif. %S2_NOLOG

-endif. %S2_USE_LAGER

-endif.
