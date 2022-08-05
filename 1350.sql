/*
Link : https://platform.stratascratch.com/coding/10350-algorithm-performance

Meta/Facebook is developing a search algorithm that will allow users to search through their post history. You are assigned to evaluate the performance of this algorithm.
We have a table with the user's search term, search result positions, and whether or not the user clicked on the search result.

Write a query that assigns ratings to the searches in the following way:
- If the search was not clicked for any term, assign the search with rating=1
- If the search was clicked but the top position of clicked terms was outside the top 3 positions, give it a rating=2
- If the search was clicked and the top position of a clicked term was in the top 3 positions, give it a rating=3

Output the search ID and it's rating.
*/

SELECT search_id, (
    CASE
        WHEN n_clicks = 0 THEN 1
        WHEN best_positions > 3 THEN 2
        WHEN best_positions <= 3 THEN 1
        END
    ) AS ratings
FROM (
    SELECT search_id, 
    SUM(clicked) AS n_clicks, 
    MIN(search_results_position) AS best_positions
    FROM fb_search_events
    GROUP BY search_id
    ) AS new_table;
