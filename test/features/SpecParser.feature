  Feature: Parse Galen Spec File

  Scenario: Declaration [case]

  Given a galen spec [spec]
  When parser is invoked
  Then it must call functions [code]

  Examples:
    case               ┆ spec                                                                   ┆ code
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    comment            ┆ ♯ this is a comment                                                    ┆ comment("this is a comment");
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Object definition  ┆ @objects                                                               ┆
                       ┆  search-panel        id    search-bar                                  ┆ defineById("search-panel","search-bar");
                       ┆  search-panel-input  xpath //div[@id='search-bar']/input[@type='text'] ┆ defineByXPath("search-panel-input", "//div[@id='search-bar']/input[@type='text']");
                       ┆  search-panel-button css   ♯search-bar a                               ┆ defineByCSS("search-panel-button","♯search-bar a");
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Object definition  ┆  search-panel-button ♯search-bar a                                     ┆ defineByCSS("search-panel-button","♯search-bar a");
     css is default    ┆                                                                        ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Object definition  ┆ @objects                                                               ┆
       Nested          ┆  search-panel   ♯search-bar                                            ┆ defineByCSS("search-panel","♯search-bar");
                       ┆    input        input[type='text']                                     ┆ defineNestedByCSS("search-panel", "search-panel-input", "input[type='text']");
                       ┆    button       a                                                      ┆ defineNestedByCSS("search-panel", "search-panel-button","search-bar a");
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Multiple objects   ┆ @objects                                                               ┆ defineMultipleByCSS("menu-item-*", "♯menu li a");
     definition        ┆   menu-item-*     css s    ♯menu li a                                  ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Objects            ┆ @objects                                                               ┆ defineById("some-test-object", "some-container").SizeCorrection(0, 1, -50, "=10")
     corrections       ┆   some-test-object    @(0, +1, -50, =10)   id  some-container          ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Objects            ┆ @objects                                                               ┆ defineById("some-test-object", "some-container").SizeCorrection(0, 0, -50, 0)
     corrections       ┆   some-test-object    @(0, 0, -50, 0)   id  some-container             ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Exact range        ┆ width 100px                                                            ┆ exactRangeInPx("width", 100)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Between range      ┆ width 50 to 200 px                                                     ┆ betweenRangeInPx("width", 50, 100)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Greater than range ┆ width > 40 px                                                          ┆ greaterThanRangeInPx("width", 40)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Less than range    ┆ width < 40 px                                                          ┆ lessThanRangeInPx("width", 40)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Approximate range  ┆ width ~ 100 px                                                         ┆ approximateRangeInPx("width", 100)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Relative ranges    ┆ width 50 % of screen/width                                             ┆ relativeExactRangeInPerc(["screen","width"], "width", 50)
      Exact            ┆                                                                        ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Relative range     ┆ width 50 to 80% % of viewport/width                                    ┆ relativeBetweenRangeInPerc(["viewport","width"],"width", 50, 80)
      Between          ┆                                                                        ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Relative range     ┆ width > 40 % of obj/width                                              ┆ relativeGreaterThanRangeInPerc(["obj","width"],"width", 40)
      Greater than     ┆                                                                        ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Relative range     ┆ width < 40 % of screen/width                                           ┆ relativeLessThanRangeInPerc(["screen","width"],"width", 40)
      Less than        ┆                                                                        ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Relative range     ┆ width ~ 95 % of screen/width                                           ┆ relativeApproximateRangeInPerc(["screen","width"],"width", 95)
      Approximate      ┆                                                                        ┆
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Relative checks    ┆ @objects                                                               ┆
      sample           ┆   main                id      main-container                           ┆ defineById("main","main-container");
                       ┆   menu                css     ul.menu                                  ┆ defineByCSS("menu", "ul.menu");
                       ┆   comments            css     div.comments                             ┆ defineByCSS("comments", "div.comments");
                       ┆                                                                        ┆
                       ┆ = Main section =                                                       ┆ section("Main section")
                       ┆   menu:                                                                ┆ object("menu")
                       ┆     width ~ 100 % of main/width                                        ┆ relativeApproximateRange(["main","width"],"width", 100)
                       ┆                                                                        ┆
                       ┆   comments:                                                            ┆ object("comments")
                       ┆     width 40 % of main/width                                           ┆ relativeExactRange(["main","width"],"width", 40%)
                       ┆     height 90 to 100 % of main/height                                  ┆ relativeBetweenRange(["main","height"],"height", 90%, 100%)
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
