<?php


function processParams($params = null) {

    if (empty($params)) {

        return array();

    }

    $paramsConverted = array();

    if (get_magic_quotes_gpc() === true) {

        if (is_array($params)) {

            foreach($params as $key => $value) {

                $paramsConverted[$key] = stripcslashes($value);

            }

        } else {

            $paramsConverted[] = stripcslashes($params);

        }

    } else {

        $paramsConverted = is_array($params) ? $params : array($params);

    }

    return $paramsConverted;

}







function query($sql = null, $params = null) {


    $objDb = new PDO('mysql:dbname='.DB_NAME.';host='.DB_HOST, DB_USER, DB_PASSWORD, array(
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ));


    $statement = $objDb->prepare($sql);


    if (!$statement) {

        $errorInfo = $objDb->errorInfo();

        throw new PDOException("Database error [{$errorInfo[0]}]: {$errorInfo[2]}, driver error code is {$errorInfo[1]}");

    }


    $paramsConverted = processParams($params);


    if (
        !$statement->execute($paramsConverted) ||
        $statement->errorCode() != '00000'
    ) {

        $errorInfo = $statement->errorInfo();

        throw new PDOException(
            "Database error [{$errorInfo[0]}]: {$errorInfo[2]}, driver error code is {$errorInfo[1]} <br /> SQL: {$sql}"
        );

    }

    return $statement;

}





function fetchRecords($sql = null, $params = null) {

    try {

        if (empty($sql)) {

            throw new PDOException('The fetchRecords function failed : missing sql');

        }

        $statement = query($sql, $params);

        return $statement->fetchAll(PDO::FETCH_ASSOC);

    } catch (PDOException $e) {

        echo $e->getMessage();
        exit();

    }

}




function fetchRecord($sql = null, $params = null) {

    try {

        if (empty($sql)) {

            throw new PDOException('The fetchRecord function failed : missing sql');

        }

        $statement = query($sql, $params);

        return $statement->fetch(PDO::FETCH_ASSOC);

    } catch (PDOException $e) {

        echo $e->getMessage();
        exit();

    }

}


function isEmpty($value = null) {

    return (
        empty($value) &&
        !is_numeric($value)
    );

}


function isGet($key = null) {

    return (
        !empty($_GET) &&
        array_key_exists($key, $_GET) &&
        !isEmpty($_GET[$key])
    );

}


function getGet($key = null) {

    if (!isGet($key)) {

        return null;

    }

    return urldecode(stripslashes($_GET[$key]));

}


function isGetValue($key = null, $value = null) {

    return (
        isGet($key) &&
        $_GET[$key] == $value
    );

}


function stickyField($key = null) {

    return getGet($key);

}


function stickySelect($key = null, $value = null) {

    return isGetValue($key, $value) ? ' selected' : null;

}



function stickyCheckboxRadio($key = null, $value = null) {

    return isGetValue($key, $value) ? ' checked' : null;

}



function makeSelect(
    $records = null,
    $name = null,
    $defaultLabel = 'Select one',
    $idField = 'id',
    $nameField = 'name'
) {

    if (empty($records)) {

        return null;

    }

    $out  = '<select name="';
    $out .= $name;
    $out .= '" id="';
    $out .= $name;
    $out .= '">';
    $out .= '<option value="">';
    $out .= $defaultLabel;
    $out .= '</option>';

    foreach($records as $row) {

        $out .= '<option value="';
        $out .= $row[$idField];
        $out .= '"';
        $out .= stickySelect($name, $row[$idField]);
        $out .= '>';
        $out .= $row[$nameField];
        $out .= '</option>';

    }

    $out .= '</select>';

    return $out;

}



function fetchSearch($expected = null, $multiple = null) {

    if (empty($expected) || !is_array($expected)) {

        return null;

    }

    $multiple = is_array($multiple) ? $multiple : array($multiple);

    $out = array();

    foreach($_GET as $key => $value) {

        $keySplit = explode('-', $key);

        if (in_array($keySplit[0], $expected) && !isEmpty($value)) {

            if (in_array($keySplit[0], $multiple)) {

                $out[$keySplit[0]][$value] = $value;

            } else {

                $out[$keySplit[0]] = urldecode($value);

            }

        }

    }

    return $out;

}



function getRecords($search = null) {

    $items = array();
    $params = array();


    $sql = "SELECT DISTINCT(`books`.`id`),
            `books`.`title` AS `Title`,
            YEAR(`books`.`date_released`) AS Year,
            `books`.`price` AS `Price`,
            `categories`.`name` AS `Category`,
            (
                SELECT
                GROUP_CONCAT(`name` ORDER BY `name` ASC SEPARATOR ', ')
                FROM `authors`
                WHERE `id` IN (
                    SELECT `author_id`
                    FROM `books_authors`
                    WHERE `book_id` = `books`.`id`
                )
            ) AS `Author`

           FROM `books`

           JOIN `categories`
                ON `categories`.`id` = `books`.`category`";

    if (!empty($search) && is_array($search)) {

        foreach($search as $key => $value) {

            switch($key) {

                case 'keyword':
                    $items[] = "`books`.`title` LIKE ?";
                    $params[] = "%{$value}%";
                    break;

                case 'category':
                    $items[] = "`categories`.`id` = ?";
                    $params[] = $value;
                    break;

                case 'cover':
                    if (!empty($value)) {
                        $items[] = "`books`.`id` IN (
                                        SELECT `book_id`
                                        FROM `books_covers`
                                        WHERE `cover_id` = ?
                                    )";
                        $params[] = $value;
                    }
                    break;
                case 'author':
                    $items[] = "`books`.`id` IN (
                                    SELECT `book_id`
                                    FROM `books_authors`
                                    WHERE `author_id` = ?
                                )";
                    $params[] = $value;
                    break;

                case 'language':
                    $items[] = "`books`.`id` IN (
                                    SELECT `book_id`
                                    FROM `books_languages`
                                    WHERE `lang_id` = ?
                                )";
                    $params[] = $value;
                    break;

                case 'year':
                    $items[] = "YEAR(`books`.`date_released`) = ?";
                    $params[] = $value;
                    break;

                case 'location':

                    $locations = implode(", ", $value);

                    $string  = "`books`.`id` IN (
                                    SELECT `book_id`
                                    FROM `books_locations`
                                    WHERE `location_id` IN ({$locations})
                                )";
                    $items[] = $string;
                    break;

            }

        }

        if (!empty($items)) {

            $sql .= " WHERE ";
            $sql .= implode(" AND ", $items);

        }

    }

    $sql .= " ORDER BY `books`.`title` ASC";

    return fetchRecords($sql, $params);

}


function getLanguages() {

    $sql = "SELECT *
            FROM `languages`
            ORDER BY `name` ASC";

    $records = fetchRecords($sql);

    return makeSelect($records, 'language', 'Select language');

}	

function getAuthors() {
		
    $sql = "SELECT *
            FROM `authors`
            ORDER BY `name` ASC";

    $records = fetchRecords($sql);

    return makeSelect($records, 'author', 'Select author');

}		

function getCategories() {

    $sql = "SELECT *
            FROM `categories`
            ORDER BY `name` ASC";

    $records = fetchRecords($sql);

    return makeSelect($records, 'category', 'Select category');

}		

function getYears() {

    $sql = "SELECT DISTINCT(YEAR(`date_released`)) AS `year`
            FROM `books`
            ORDER BY `date_released` ASC";

    $records = fetchRecords($sql);

    return makeSelect($records, 'year', 'Select year', 'year', 'year');
}

function getCovers() {

    $sql = "SELECT *
            FROM `covers`
            ORDER BY `name` ASC";

    $records = fetchRecords($sql);

    if (empty($records)) {

        return null;

    }

    $out  = '<ul class="medium-block-grid-3">';

    $out .= '<li>';
    $out .= '<label for="cover-0">';
    $out .= '<input type="radio" name="cover" id="cover-0" value="0"';
    $out .= isGetValue('cover', '0') ? ' checked' : null;
    $out .= '> Any cover</label>';
    $out .= '</li>';

    foreach($records as $row) {

        $out .= '<li>';
        $out .= '<label for="cover-';
        $out .= $row['id'];
        $out .= '">';
        $out .= '<input type="radio" name="cover" id="cover-';
        $out .= $row['id'];
        $out .= '" value="';
        $out .= $row['id'];
        $out .= '"';
        $out .= stickyCheckboxRadio('cover', $row['id']);
        $out .= '> ';
        $out .= $row['name'];
        $out .= '</label>';
        $out .= '</li>';

    }

    $out .= '</ul>';

    return $out;

}		

function getLocations() {

    $sql = "SELECT * FROM
            `locations` ORDER BY
            `name` ASC";

    $records = fetchRecords($sql);

    $out  = '<ul class="medium-block-grid-6">';

    foreach($records as $row) {

        $out .= '<li>';
        $out .= '<label for="location-';
        $out .= $row['id'];
        $out .= '">';
        $out .= '<input type="checkbox" name="location-';
        $out .= $row['id'];
        $out .= '" id="location-';
        $out .= $row['id'];
        $out .= '" value="';
        $out .= $row['id'];
        $out .= '"';
        $out .= stickyCheckboxRadio('location-'.$row['id'], $row['id']);
        $out .= '> ';
        $out .= $row['name'];
        $out .= '</label>';
        $out .= '</li>';

    }

    $out .= '</ul>';

    return $out;

}
