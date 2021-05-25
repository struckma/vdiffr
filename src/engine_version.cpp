#include "engine_version.h"
#include <cpp11/strings.hpp>

std::string ENGINE_VERSION = "";

std::string get_engine_version() {
  return ENGINE_VERSION;
}

[[cpp11::register]]
void set_engine_version(cpp11::strings version) {
  ENGINE_VERSION = cpp11::as_cpp<std::string>(version);
}
