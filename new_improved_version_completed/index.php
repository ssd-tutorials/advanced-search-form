<?php

require_once("inc/config.php");
require_once("inc/functions.php");

$params = fetchSearch(
    array(
        'keyword',
        'category',
        'cover',
        'author',
        'language',
        'year',
        'location'
    ),
    array(
        'location'
    )
);

$records = getRecords($params);

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Advanced Search Form</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/foundation.min.css">
    <link rel="stylesheet" href="css/core.css">
</head>
<body>

<div class="row">

    <div class="column">

        <h1>Advanced Search Form</h1>


        <form
          id="search_form"
          method="get"
          >


            <div class="row">

                <div class="medium-6 columns">

                    <label
                        for="keyword"
                        >
                        Keyword:
                        </label>

                    <input
                        type="text"
                        name="keyword"
                        id="keyword"
                        value="<?php echo stickyField('keyword'); ?>"
                        >

                </div>

                <div class="medium-6 columns">

                    <label
                        for="cover"
                        >
                        Cover type:
                    </label>

                    <?php echo getCovers(); ?>

                </div>

            </div>



            <div class="row">

                <div class="medium-6 columns">

                    <label
                        for="category"
                        >
                        Category:
                        </label>

                    <?php echo getCategories(); ?>

                </div>


                <div class="medium-6 columns">

                    <label
                        for="author"
                        >
                        Author:
                    </label>

                    <?php echo getAuthors(); ?>

                </div>

            </div>




            <div class="row">

                <div class="medium-6 columns">

                    <label
                        for="language"
                        >
                        Language:
                    </label>

                    <?php echo getLanguages(); ?>

                </div>

                <div class="medium-6 columns">

                    <label
                        for="year"
                        >
                        Year:
                    </label>

                    <?php echo getYears(); ?>

                </div>

            </div>


            <div class="row">

                <div class="column">

                    <label
                        for="location"
                        >
                        Available in:
                    </label>

                    <?php echo getLocations(); ?>

                </div>

            </div>


            <div class="row">

                <div class="column">

                    <ul class="button-group">

                        <li>
                            <button
                                type="submit"
                                class="small button"
                                >SUBMIT</button>
                        </li>
                        <li>
                            <a
                                href="/"
                                class="small button alert"
                                >RESET</a>
                        </li>

                    </ul>

                </div>

            </div>



        </form>




        <div class="divider brtd"></div>




        <?php if (!empty($records)) { ?>

            <table class="tableList">

                <thead>

                    <tr>
                        <th>
                            Book title
                        </th>
                        <th>
                            Category
                        </th>
                        <th>
                            Author(s)
                        </th>
                        <th>
                            Year
                        </th>
                        <th>
                            Price
                        </th>
                    </tr>

                </thead>

                <?php foreach($records as $row) { ?>

                    <tr>
                        <td>
                            <?php echo $row['Title']; ?>
                        </td>
                        <td>
                            <?php echo $row['Category']; ?>
                        </td>
                        <td>
                            <?php echo $row['Author']; ?>
                        </td>
                        <td>
                            <?php echo $row['Year']; ?>
                        </td>
                        <td>
                            <?php echo $row['Price']; ?>
                        </td>
                    </tr>

                <?php } ?>

            </table>

        <?php } else { ?>

            <p>There are no records available.</p>

        <?php } ?>



    </div>

</div>


</body>
</html>