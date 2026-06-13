# Structure and Interpretation of Computer Programs

These are my solutions to some of the problems in 
[the Wizard Book](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/index.html).
I am reading through the book as a form of intellectual
pleasure this Summer, Year 2026. The solution scripts
are ordered below by the order in which I implemented them.

## Quickstart

I use [Racket](https://racket-lang.org/) for this project,
and the sicp package available within the raco ecosystem.

To install the scip package, add the Racket installation to
your path and run the following command to install the package:

```console
$ raco pkg install sicp
```

Now you should be able to run the code like this,

```console
$ racket hello_world.scm
> Hello, World.
```

Once sicp has been installed, any script should begin with the
`#lang` line to be compatible with the book:

```scheme
#lang sicp
```

## Chapter One

[Chapter 1](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-9.html#%_chap_1)

1. [hello_world](src/hello_world.scm)
2. [squaring](src/squaring.scm)
3. [conditions](src/conditions.scm)
4. [more_complicated_functions](src/more_complicated_functions.scm)
5. [operators_as_compound_exprs](src/operators_as_compound_exprs.scm)
6. [ben_bitdiddles_test](src/ben_bitdiddles_test.scm)
7. [sqrt_by_newtons_method](src/sqrt_by_newtons_method.scm)
8. [lexical_scoping](src/lexical_scoping.scm)
9. [factorial](src/factorial.scm)
10. [process_examples](src/process_examples.scm)
11. [ackermann_func](src/ackermann_func.scm)
12. [fibonacci](src/fibonacci.scm)
13. [sine](src/sine.scm)
14. [exponentiation](src/exponentiation.scm)
15. [faster_exponentiation](src/faster_exponentiation.scm)
16. [repeated_addition](src/repeated_addition.scm)
17. [faster_fibonacci](src/faster_fibonacci.scm)
18. [greatest_common_devisor](src/greatest_common_devisor.scm)
19. [prime_numbers](src/prime_numbers.scm)
20. [procedures_as_arguments](src/procedures_as_arguments.scm)
21. [let](src/let.scm)
22. [half_interval_method](src/half_interval_method.scm)
23. [fixed_points](src/fixed_points.scm)
24. [continued_fractions](src/continued_fractions.scm)
25. [average_damping](src/average_damping.scm)
26. [newtons_method](src/newtons_method.scm)

## Chapter Two

[Chapter 2](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-13.html#%_chap_2)

1. [wishful_thinking](src/wishful_thinking.scm)
2. [pairs](src/pairs.scm)
3. [representing_rational_nums](src/representing_rational_nums.scm)
4. [points_and_segments](src/points_and_segments.scm)
5. [custom_cons](src/custom_cons.scm)
6. [more_custom_cons](src/more_custom_cons.scm)
7. [church_numerals](src/church_numerals.scm)
8. [interval_arithmetic](src/interval_arithmetic.scm)
9. [sequences](src/sequences.scm)
10. [list_operations](src/list_operations.scm)
11. [parity](src/parity.scm)
12. [mappings](src/mappings.scm)
13. [foreach](src/foreach.scm)
14. [lists_as_trees](src/lists_as_trees.scm)
15. [binary_mobile](src/binary_mobile.scm)
16. [power_set](src/power_set.scm)
17. [sequences_as_interfaces](src/sequences_as_interfaces.scm)
18. [matrix_ops](src/matrix_ops.scm)
19. [folding_left_and_right](src/folding_left_and_right.scm)
20. [flatmap](src/flatmap.scm)
21. [permutations](src/permutations.scm)
22. [unique_pairs](src/unique_pairs.scm)
23. [ordered_triples](src/ordered_triples.scm)
24. [queens](src/queens.scm)
25. [queens_faster](src/queens_faster.scm)
26. [queens_symmetry](src/queens_symmetry.scm)
27. [memq](src/memq.scm)
28. [quote_craziness](src/quote_craziness.scm)
29. [symbolic_differentiation](src/symbolic_differentiation.scm)
30. [sets_as_unordered_lists](src/sets_as_unordered_lists.scm)
31. [sets_as_ordered_lists](src/sets_as_ordered_lists.scm)
32. [sets_as_binary_trees](src/sets_as_binary_trees.scm)
33. [huffman_encoding](src/huffman_encoding.scm)
34. [huffman_encoding_1950s_rock_song](src/huffman_encoding_1950s_rock_song.scm)
35. [dispatch_on_type_complex_numbers](src/dispatch_on_type_complex_numbers.scm)
36. [data_directed_complex_numbers](src/data_directed_complex_numbers.scm)

## Chapter Three

[Chapter 3](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-19.html#%_chap_3)

1. [withdraw](src/withdraw.scm)
2. [bank](src/bank.scm)
3. [accumulator](src/accumulator.scm)
4. [monitor](src/monitor.scm)
5. [rand](src/rand.scm)
6. [monte_carlo](src/monte_carlo.scm)
7. [monte_carlo_integration](src/monte_carlo_integration.scm)
8. [order_of_evaluation](src/order_of_evaluation.scm)
9. [mut_append](src/mut_append.scm)
10. [cycle](src/cycle.scm)
11. [mystery](src/mystery.scm)
12. [counting_pairs](src/counting_pairs.scm)
13. [contains_cycle](src/contains_cycle.scm)
14. [mutation_as_assignment](src/mutation_as_assignment.scm)
15. [queue](src/queue.scm)
16. [state_queue](src/state_queue.scm)
17. [deque](src/deque.scm)
18. [table](src/table.scm)
19. [table_two_dim](src/table_two_dim.scm)
20. [table_n_dim](src/table_n_dim.scm)
21. [memoized_fibonacci](src/memoized_fibonacci.scm)
22. [sum_primes_in_interval](src/sum_primes_in_interval.scm)
23. [stream_operations](src/stream_operations.scm)
24. [mixing_delay_and_assignment](src/mixing_delay_and_assignment.scm)
25. [more_display_of_delays](src/more_display_of_delays.scm)
26. [infinite_streams](src/infinite_streams.scm)
27. [add_streams](src/add_streams.scm)
28. [scale_streams](src/scale_streams.scm)
29. [implicit_streams](src/implicit_streams.scm)
30. [hammings_problem](src/hammings_problem.scm)
31. [expand](src/expand.scm)
32. [power_series](src/power_series.scm)
33. [inverted_power_series](src/inverted_power_series.scm)
34. [iterations_as_streams](src/iterations_as_streams.scm)
35. [accelerated_streams](src/accelerated_streams.scm)
36. [natural_logarithm_stream](src/natural_logarithm_stream.scm)
37. [streams_of_pairs](src/streams_of_pairs.scm)
38. [more_pair_streams](src/more_pair_streams.scm)
39. [triples](src/triples.scm)
40. [merge_weighted](src/merge_weighted.scm)
41. [ramanujan](src/ramanujan.scm)

## Book Reference

[SCIP](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book.html)
