# Structure and Interpretation of Computer Programs

These are my solutions to some of the problems in 
[the Wizard Book](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/index.html).
I am reading through the book as a form of intellectual
pleasure this Summer, Year 2026. The solution scripts
are ordered below by the order in which I implemented them
as I studied this text.

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
`#lang` line

```racket
#lang sicp
```

## Chapter One

[Chapter 1](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-9.html#%_chap_1)

1. hello_world.rkt
2. squaring.rkt
3. conditions.rkt
4. more_complicated_functions.rkt
5. operators_as_compound_exprs.rkt
6. ben_bitdiddles_test.rkt
7. sqrt_by_newtons_method.rkt
8. lexical_scoping.rkt
9. factorial.rkt
10. process_examples.rkt
11. ackermann_func.rkt
12. fibonacci.rkt
13. sine.rkt
14. exponentiation.rkt
15. faster_exponentiation.rkt
16. repeated_addition.rkt
17. faster_fibonacci.rkt
18. greatest_common_devisor.rkt
19. prime_numbers.rkt
20. procedures_as_arguments.rkt
21. let.rkt
22. half_interval_method.rkt
23. fixed_points.rkt
24. continued_fractions.rkt
25. average_damping.rkt
26. newtons_method.rkt

## Chapter Two

[Chapter 2](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-13.html#%_chap_2)

1. wishful_thinking.rkt
2. pairs.rkt
3. representing_rational_nums.rkt
4. points_and_segments.rkt
5. custom_cons.rkt
6. more_custom_cons.rkt
7. church_numerals.rkt
8. interval_arithmetic.rkt
9. sequences.rkt
10. list_operations.rkt
11. parity.rkt
12. mappings.rkt
13. foreach.rkt
14. lists_as_trees.rkt
15. binary_mobile.rkt
16. power_set.rkt
17. sequences_as_interfaces.rkt
18. matrix_ops.rkt
19. folding_left_and_right.rkt
20. flatmap.rkt
21. permutations.rkt
22. unique_pairs.rkt
23. ordered_triples.rkt
24. queens.rkt
25. queens_faster.rkt
26. queens_symmetry.rkt
27. memq.rkt
28. quote_craziness.rkt
29. symbolic_differentiation.rkt
30. sets_as_unordered_lists.rkt
31. sets_as_ordered_lists.rkt
32. sets_as_binary_trees.rkt
33. huffman_encoding.rkt
34. huffman_encoding_1950s_rock_song.rkt
35. dispatch_on_type_complex_numbers.rkt
36. data_directed_complex_numbers.rkt
37. symbolic_algebra.rkt *UNFINISHED*

## Chapter Three

[Chapter 3](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book-Z-H-19.html#%_chap_3)

1. withdraw.rkt
2. bank.rkt
3. accumulator.rkt
4. monitor.rkt
5. rand.rkt
6. monte_carlo.rkt
7. monte_carlo_integration.rkt
8. order_of_evaluation.rkt
9. mut_append.rkt
10. cycle.rkt
11. mystery.rkt
12. counting_pairs.rkt
13. contains_cycle.rkt
14. mutation_as_assignment.rkt
15. queue.rkt
16. state_queue.rkt
17. deque.rkt
18. table.rkt
19. table_two_dim.rkt
20. table_n_dim.rkt
21. memoized_fibonacci.rkt
22. digital_circuits.rkt

## Book Reference

[SCIP](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/book.html)
