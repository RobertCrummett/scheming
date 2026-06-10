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
$ racket hello_world.rkt
> Hello, World.
```

Once sicp has been installed, any script should begin with the
`#lang` line to be compatible with the book:

```racket
#lang sicp
```

## Chapter One

[Chapter 1](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-9.html#%_chap_1)

1. [hello_world](src/hello_world.rkt)
2. [squaring](src/squaring.rkt)
3. [conditions](src/conditions.rkt)
4. [more_complicated_functions](src/more_complicated_functions.rkt)
5. [operators_as_compound_exprs](src/operators_as_compound_exprs.rkt)
6. [ben_bitdiddles_test](src/ben_bitdiddles_test.rkt)
7. [sqrt_by_newtons_method](src/sqrt_by_newtons_method.rkt)
8. [lexical_scoping](src/lexical_scoping.rkt)
9. [factorial](src/factorial.rkt)
10. [process_examples](src/process_examples.rkt)
11. [ackermann_func](src/ackermann_func.rkt)
12. [fibonacci](src/fibonacci.rkt)
13. [sine](src/sine.rkt)
14. [exponentiation](src/exponentiation.rkt)
15. [faster_exponentiation](src/faster_exponentiation.rkt)
16. [repeated_addition](src/repeated_addition.rkt)
17. [faster_fibonacci](src/faster_fibonacci.rkt)
18. [greatest_common_devisor](src/greatest_common_devisor.rkt)
19. [prime_numbers](src/prime_numbers.rkt)
20. [procedures_as_arguments](src/procedures_as_arguments.rkt)
21. [let](src/let.rkt)
22. [half_interval_method](src/half_interval_method.rkt)
23. [fixed_points](src/fixed_points.rkt)
24. [continued_fractions](src/continued_fractions.rkt)
25. [average_damping](src/average_damping.rkt)
26. [newtons_method](src/newtons_method.rkt)

## Chapter Two

[Chapter 2](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-13.html#%_chap_2)

1. [wishful_thinking](src/wishful_thinking.rkt)
2. [pairs](src/pairs.rkt)
3. [representing_rational_nums](src/representing_rational_nums.rkt)
4. [points_and_segments](src/points_and_segments.rkt)
5. [custom_cons](src/custom_cons.rkt)
6. [more_custom_cons](src/more_custom_cons.rkt)
7. [church_numerals](src/church_numerals.rkt)
8. [interval_arithmetic](src/interval_arithmetic.rkt)
9. [sequences](src/sequences.rkt)
10. [list_operations](src/list_operations.rkt)
11. [parity](src/parity.rkt)
12. [mappings](src/mappings.rkt)
13. [foreach](src/foreach.rkt)
14. [lists_as_trees](src/lists_as_trees.rkt)
15. [binary_mobile](src/binary_mobile.rkt)
16. [power_set](src/power_set.rkt)
17. [sequences_as_interfaces](src/sequences_as_interfaces.rkt)
18. [matrix_ops](src/matrix_ops.rkt)
19. [folding_left_and_right](src/folding_left_and_right.rkt)
20. [flatmap](src/flatmap.rkt)
21. [permutations](src/permutations.rkt)
22. [unique_pairs](src/unique_pairs.rkt)
23. [ordered_triples](src/ordered_triples.rkt)
24. [queens](src/queens.rkt)
25. [queens_faster](src/queens_faster.rkt)
26. [queens_symmetry](src/queens_symmetry.rkt)
27. [memq](src/memq.rkt)
28. [quote_craziness](src/quote_craziness.rkt)
29. [symbolic_differentiation](src/symbolic_differentiation.rkt)
30. [sets_as_unordered_lists](src/sets_as_unordered_lists.rkt)
31. [sets_as_ordered_lists](src/sets_as_ordered_lists.rkt)
32. [sets_as_binary_trees](src/sets_as_binary_trees.rkt)
33. [huffman_encoding](src/huffman_encoding.rkt)
34. [huffman_encoding_1950s_rock_song](src/huffman_encoding_1950s_rock_song.rkt)
35. [dispatch_on_type_complex_numbers](src/dispatch_on_type_complex_numbers.rkt)
36. [data_directed_complex_numbers](src/data_directed_complex_numbers.rkt)

## Chapter Three

[Chapter 3](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-19.html#%_chap_3)

1. [withdraw](src/withdraw.rkt)
2. [bank](src/bank.rkt)
3. [accumulator](src/accumulator.rkt)
4. [monitor](src/monitor.rkt)
5. [rand](src/rand.rkt)
6. [monte_carlo](src/monte_carlo.rkt)
7. [monte_carlo_integration](src/monte_carlo_integration.rkt)
8. [order_of_evaluation](src/order_of_evaluation.rkt)
9. [mut_append](src/mut_append.rkt)
10. [cycle](src/cycle.rkt)
11. [mystery](src/mystery.rkt)
12. [counting_pairs](src/counting_pairs.rkt)
13. [contains_cycle](src/contains_cycle.rkt)
14. [mutation_as_assignment](src/mutation_as_assignment.rkt)
15. [queue](src/queue.rkt)
16. [state_queue](src/state_queue.rkt)
17. [deque](src/deque.rkt)
18. [table](src/table.rkt)
19. [table_two_dim](src/table_two_dim.rkt)
20. [table_n_dim](src/table_n_dim.rkt)
21. [memoized_fibonacci](src/memoized_fibonacci.rkt)
22. [sum_primes_in_interval](src/sum_primes_in_interval.rkt)
23. [stream_operations](src/stream_operations.rkt)
24. [mixing_delay_and_assignment](src/mixing_delay_and_assignment.rkt)
25. [more_display_of_delays](src/more_display_of_delays.rkt)
26. [infinite_streams](src/infinite_streams.rkt)
27. [add_streams](src/add_streams.rkt)
28. [scale_streams](src/scale_streams.rkt)
29. [implicit_streams](src/implicit_streams.rkt)
30. [hammings_problem](src/hammings_problem.rkt)
31. [expand](src/expand.rkt)
32. [power_series](src/power_series.rkt)

## Book Reference

[SCIP](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book.html)
