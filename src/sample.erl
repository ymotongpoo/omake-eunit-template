%%%-----------------------------------------------------------------------------
%%% @author Yoshifumi YAMAGUCHI <ymotongpoo AT gmail.com>
%%% @copyright (C) 2010, Yoshifumi YAMAGUCHI
%%% @doc
%%%
%%% @end
%%% Created : 23 Oct 2010 by Yoshifumi YAMAGUCHI <ymotongpoo AT gmail.com>
%%%-----------------------------------------------------------------------------

-module(sample).
-define(EUNIT, true)
-export([bottom/1, sift/2, sieve/1, primes/1, nth_prime/1]).
-compile(export_all).

%%%-----------------------------------------------------------------------------

bottom(List)->
    case List of
        [] -> [];
        [X] -> X;
        [_|Xs] -> bottom(Xs)
    end.


sift(Divider, Nums)->
    lists:filter(fun(X) -> X rem Divider =/= 0 end, Nums).


sieve(Nums)->
    sieve([], Nums).
sieve(Accu, Nums)->
    case {Accu, Nums} of
        {_, []} ->
            Accu;
        {[], _} ->
            sieve([hd(Nums)], sift(hd(Nums), tl(Nums)));
        {_, [X|Xs]} ->
            B = bottom(Xs),
            if 
               X*X > B ->
                    lists:reverse(Accu, Nums);
               true ->
                    sieve([X|Accu], sift(X, Xs))
            end
    end.

primes(Limit)->
    sieve(lists:seq(2, Limit)).



%%%-----------------------------------------------------------------------------

-ifdef(EUNIT).
-include_lib("eunit/include/eunit.hrl").

bottom_test_()->
    [?_assert( [] =:= bottom([]) ),
     ?_assert( 1 =:= bottom([1]) ),
     ?_assert( 10 =:= bottom(lists:seq(1, 10)) ),
     ?_assert( d =:= bottom([a, b, c, d]) )
    ].

sift_test_()->
    [?_assert( [] =:= sift(2, []) ),
     ?_assert( [] =:= sift(1, lists:seq(1, 5)) ),
     ?_assert( lists:seq(1, 9, 2) =:= sift(2, lists:seq(1, 10)) )
    ].

sieve_test_()->
    [?_assert( [] =:= sieve([]) ),
     ?_assert( [1] =:= sieve(lists:seq(1,10)) ),
     ?_assert( [2,3,5,7] =:= sieve(lists:seq(2,10)) )
    ].

primes_test_()->
    [?_assert( [2] =:= primes(2) ),
     ?_assert( [2,3,5,7] =:= primes(10) )
    ].


-endif.
