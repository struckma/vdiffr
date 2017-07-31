// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// compare_files
bool compare_files(std::string expected, std::string test);
RcppExport SEXP _vdiffr_compare_files(SEXP expectedSEXP, SEXP testSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type expected(expectedSEXP);
    Rcpp::traits::input_parameter< std::string >::type test(testSEXP);
    rcpp_result_gen = Rcpp::wrap(compare_files(expected, test));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_vdiffr_compare_files", (DL_FUNC) &_vdiffr_compare_files, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_vdiffr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
