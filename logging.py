# -*- coding: utf-8 -*-
# ---------------------------------------------------------------------------
#   logging.py
#
# This provides easy logging related functions
# ---------------------------------------------------------------------------

from os import listdir, remove as rmfile
from os.path import join as path_join
import logging
import logging.handlers


def create_logger(log_filename, logger_name=__name__, log_dir="/tmp", debug=True, clean_log=True, log_to_file=True, log_to_screen=False):
    """
        Creates logger object with desired level of detail (in really just debug or not)

    :param log_filename: The output file is in /tmp/<log_filename>.log
    :param logger_name: Logger name
    :param log_dir: Default /tmp.
    :param debug: Defines debug detail level activated. Default True (means development)
    :param clean_log: Empty log on start.
    :param log_to_file: Enable write log messages to file; Default True
    :param log_to_screen: Enable write log messages to screen; Default True
    :return (logger object): Return logger object
    """
    log_file = path_join(log_dir, log_filename + ".log")
    def _clean_all_logs():
        for file_name in listdir(log_dir):
            if file_name.startswith(log_filename + ".log"):
                rmfile(path_join(log_dir,file_name))

    if debug:
        log_level = logging.DEBUG
    else:
        log_level = logging.INFO

    logger = logging.getLogger(logger_name)
    logger.setLevel(log_level)
    formatter = logging.Formatter("%(asctime)s - [PID %(process)d] %(module)s - %(levelname)s -> %(message)s",
                                    "%Y-%m-%d %H:%M:%S")

    if log_to_file:
        if clean_log:  # Clean-log session
            _clean_all_logs()
            hdlr = logging.handlers.RotatingFileHandler(log_file,
                                                        mode='w',
                                                        encoding="UTF-8",
                                                        maxBytes=1000000,
                                                        backupCount=20)
        else:
            hdlr = logging.handlers.RotatingFileHandler(log_file,
                                                        mode='a',
                                                        encoding="UTF-8",
                                                        maxBytes=1000000,
                                                        backupCount=20)
        hdlr.setFormatter(formatter)
        logger.addHandler(hdlr) 
    if log_to_screen:
        hdlr = logging.StreamHandler()
        hdlr.setFormatter(formatter)
        logger.addHandler(hdlr)
    if not log_to_screen and not log_to_file:
        hdlr = logging.NullHandler()
        hdlr.setFormatter(formatter)
        logger.addHandler(hdlr)
    return logger

def close_loggers():
    """
        Shutdown all logging stuff
    """
    logging.shutdown()
