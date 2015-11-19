INSERT INTO `authors` VALUES(1, 'Darren Shan');
INSERT INTO `authors` VALUES(2, 'M.R. James');
INSERT INTO `authors` VALUES(3, 'Stephenie Meyer');
INSERT INTO `authors` VALUES(4, 'Nora Roberts');

INSERT INTO `categories` VALUES(1, 'Romance');
INSERT INTO `categories` VALUES(2, 'Art');
INSERT INTO `categories` VALUES(3, 'Comedy');
INSERT INTO `categories` VALUES(4, 'Horror');


INSERT INTO `covers` VALUES(1, 'Soft');
INSERT INTO `covers` VALUES(2, 'Hard');


INSERT INTO `languages` VALUES(1, 'English');
INSERT INTO `languages` VALUES(2, 'French');
INSERT INTO `languages` VALUES(3, 'German');
INSERT INTO `languages` VALUES(4, 'Spanish');
INSERT INTO `languages` VALUES(5, 'Italian');
INSERT INTO `languages` VALUES(6, 'Polish');


INSERT INTO `locations` VALUES(1, 'London');
INSERT INTO `locations` VALUES(2, 'Brighton');
INSERT INTO `locations` VALUES(3, 'Bournemouth');
INSERT INTO `locations` VALUES(4, 'Portsmouth');
INSERT INTO `locations` VALUES(5, 'Southampton');
INSERT INTO `locations` VALUES(6, 'Chichester');


INSERT INTO `books` VALUES(1, '1405678151', 'Ghost Stories', 'This is the second collection of chilling ghost stories by M. R. James. "A Warning to the Curious" features a young man who excavates an ancient crown - but soon wishes he had let it stay buried. In "The Mezzotint" an engraving of a manor house reveals more than first meets the eye, while in "The Stalls of Barchester Cathedral", an archdeacon''s journal reveals the strange circumstances that led to his death. The final story, "A Neighbour''s Landmark", tells of a gentleman whose curiosity is piqued by a strange rhyme, leading him to take a walk through Betton Woods...Read by BAFTA and Emmy-award winning actor Derek Jacobi ("Cadfael", "Gosford Park", "Doctor Who"), and with eerie, evocative music, these four haunting stories will thrill anyone who loves to be terrified.', 4, 6.99, '2005-10-10', '2009-10-10 19:53:49');
INSERT INTO `books` VALUES(2, '0007260342', 'Hell''s Heroes', 'The final dramatic conclusion to Darren Shan''s international phenomena, The Demonata. Expect the unexpected! The final dramatic conclusion to Darren Shan''s international phenomena, The Demonata. Expect the unexpected!', 4, 6.49, '2001-10-09', '2009-10-08 19:59:04');
INSERT INTO `books` VALUES(3, '1904233651', 'Twilight', 'When 17 year old Isabella Swan moves to Forks, Washington to live with her father she expects that her new life will be as dull as the town. But in spite of her awkward manner and low expectations, she finds that her new classmates are drawn to this pale, dark-haired new girl in town. But not, it seems, the Cullen family. These five adopted brothers and sisters obviously prefer their own company and will make no exception for Bella. Bella is convinced that Edward Cullen in particular hates her, but she feels a strange attraction to him, although his hostility makes her feel almost physically ill. He seems determined to push her away ? until, that is, he saves her life from an out of control car. Bella will soon discover that there is a very good reason for Edward''s coldness. He, and his family, are vampires ? and he knows how dangerous it is for others to get too close.', 1, 3.49, '2007-10-29', '2009-10-13 20:01:52');
INSERT INTO `books` VALUES(4, '074992926X', 'Black Hills', 'Lil Chance fell in love with Cooper Sullivan pretty much the first time she saw him, an awkward teenager staying with his grandparents on their cattle ranch in South Dakota while his parents went through a messy divorce. Each year, with Coop''s annual summer visit, their friendship deepens - but then abruptly ends. Twelve years later and Cooper has returned to run the ranch after his grandfather is injured in a fall. Though his touch still haunts her, Lil has let nothing stop her dream of opening the Chance Wildlife Refuge, but something - or someone - has been keeping a close watch. When small pranks escalate into heartless killing, the memory of an unsolved murder in these very hills has Cooper springing to action to keep Lil safe. They both know the dangers that lurk in the wild landscape of the Black Hills. And now they must work together to unearth a killer of twisted and unnatural instincts who has singled them out as prey', 1, 7.19, '2001-10-08', '2009-10-13 00:00:00');


INSERT INTO `books_authors` VALUES(1, 2);
INSERT INTO `books_authors` VALUES(2, 1);
INSERT INTO `books_authors` VALUES(3, 3);
INSERT INTO `books_authors` VALUES(4, 4);


INSERT INTO `books_covers` VALUES(3, 1);
INSERT INTO `books_covers` VALUES(4, 1);
INSERT INTO `books_covers` VALUES(1, 2);
INSERT INTO `books_covers` VALUES(2, 2);
INSERT INTO `books_covers` VALUES(3, 2);


INSERT INTO `books_languages` VALUES(1, 1);
INSERT INTO `books_languages` VALUES(1, 2);
INSERT INTO `books_languages` VALUES(2, 1);
INSERT INTO `books_languages` VALUES(2, 3);
INSERT INTO `books_languages` VALUES(2, 4);
INSERT INTO `books_languages` VALUES(2, 5);
INSERT INTO `books_languages` VALUES(3, 1);
INSERT INTO `books_languages` VALUES(3, 2);
INSERT INTO `books_languages` VALUES(3, 3);
INSERT INTO `books_languages` VALUES(3, 4);
INSERT INTO `books_languages` VALUES(4, 1);
INSERT INTO `books_languages` VALUES(4, 2);


INSERT INTO `books_locations` VALUES(1, 1);
INSERT INTO `books_locations` VALUES(1, 2);
INSERT INTO `books_locations` VALUES(2, 2);
INSERT INTO `books_locations` VALUES(2, 4);
INSERT INTO `books_locations` VALUES(3, 1);
INSERT INTO `books_locations` VALUES(3, 2);
INSERT INTO `books_locations` VALUES(3, 3);
INSERT INTO `books_locations` VALUES(3, 5);
INSERT INTO `books_locations` VALUES(4, 1);
INSERT INTO `books_locations` VALUES(4, 3);