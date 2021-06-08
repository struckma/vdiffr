# thematic

<details>

* Version: 0.1.2
* GitHub: https://github.com/rstudio/thematic
* Source code: https://github.com/cran/thematic
* Date/Publication: 2021-03-29 15:00:03 UTC
* Number of recursive dependencies: 122

Run `cloud_details(, "thematic")` for more info

</details>

## Newly broken

*   checking tests ... ERROR
    ```
      Running ‘testthat.R’
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      y[1]: "purple"
      ── Failure (test-state.R:51:3): Getting options ────────────────────────────────
      thematic_get_option("fg", "yellow") not equal to "yellow".
      1/1 mismatches
      x[1]: "white"
      y[1]: "yellow"
      ── Failure (test-state.R:52:3): Getting options ────────────────────────────────
      thematic_get_option("accent", "orange") not equal to "orange".
      1/1 mismatches
      x[1]: "green"
      y[1]: "orange"
      
      [ FAIL 6 | WARN 0 | SKIP 16 | PASS 21 ]
      Error: Test failures
      Execution halted
    ```

