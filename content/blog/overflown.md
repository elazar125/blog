+++
title = "Overflown"
description = "A vexing CSS overflow/position gotcha that gotch me"
date = "2023-08-26"
+++

## Firstly, some Prior Art

I figured this out thanks to an article by Agop Shirinian posted to CSS Tricks here: [https://css-tricks.com/popping-hidden-overflow/](https://css-tricks.com/popping-hidden-overflow/)

I want to write this post too because I think the example provided was a little too realistic for me to really figure out what's going on. I wanted something way simpler.

## Here's the broken version

```html
<div style="
  position: relative;
  overflow-y: scroll;
  overflow-x: visible;
  max-height: 100px;
  max-width: 500px;
">
Here's some content that's too long and scrolls

And a picture of a bike that should be positioned absolute to the right of this text

Even though the horizontal overflow is set to visible, we get a horizontal scroll

Some lorem ipsum...
  <img src="/img/bike.avif" style="
    height: 200px;
    max-width: fit-content; /* Needed to override my site's styles */
    position: absolute;
    top: 0;
    left: 500px;
  " />
</div>
```

<div style="
  position: relative;
  overflow-y: scroll;
  overflow-x: visible;
  max-height: 100px;
  max-width: 500px;
">
Here's some content that's too long and scrolls

And a picture of a bike that should be positioned absolute to the right of this text

Even though the horizontal overflow is set to visible, we get a horizontal scroll

Dolores dolores autem et. Porro ad sit porro veniam voluptas nemo. Porro autem inventore consectetur sit et non.

Rerum ut magni sint nemo porro totam suscipit veniam. Veritatis ipsum minima illum repellendus fuga. Dolor dignissimos blanditiis et sit aut quia. Dolores qui nesciunt odit.

Commodi provident doloribus dolorem nobis voluptatem beatae pariatur. Sit dignissimos possimus magni possimus autem dolor placeat. Ad ipsam praesentium ut nam eos. Sit eaque officiis ea dolorem.

Adipisci totam rerum corrupti. Dolores repellat provident incidunt omnis eligendi quo excepturi illum. Doloremque architecto ut ab nobis veritatis sint asperiores sint.

Perferendis sint unde harum exercitationem culpa dolor praesentium error. Aliquid aperiam eum aut quaerat. Non aspernatur quam ut qui quia. Quam illum odit rerum cumque.
  <img src="/img/bike.avif" style="
    height: 200px;
    max-width: fit-content; /* Needed to override my site's styles */
    position: absolute;
    top: 0;
    left: 500px;
  " />
</div>

## Here's the fixed version

```html
<div style="
  position: relative;
">
  <div style="
    overflow-y: scroll;
    overflow-x: visible;
    max-height: 100px;
    max-width: 500px;
  ">
Here's some content that's too long and scrolls

And a picture of a bike that should be positioned absolute to the right of this text

Now the text scrolls but you can still see the bike sticking out to the side!

Some Lorem ipsum...
    <img src="/img/bike.avif" style="
      height: 200px;
      max-width: fit-content; /* Needed to override my site's styles */
      position: absolute;
      top: 0;
      left: 500px;
    " />
  </div>
</div>
```

<div style="
  position: relative;
">
  <div style="
    overflow-y: scroll;
    overflow-x: visible;
    max-height: 100px;
    max-width: 500px;
  ">
Here's some content that's too long and scrolls

And a picture of a bike that should be positioned absolute to the right of this text

Now the text scrolls but you can still see the bike sticking out to the side!

Dolores dolores autem et. Porro ad sit porro veniam voluptas nemo. Porro autem inventore consectetur sit et non.

Rerum ut magni sint nemo porro totam suscipit veniam. Veritatis ipsum minima illum repellendus fuga. Dolor dignissimos blanditiis et sit aut quia. Dolores qui nesciunt odit.

Commodi provident doloribus dolorem nobis voluptatem beatae pariatur. Sit dignissimos possimus magni possimus autem dolor placeat. Ad ipsam praesentium ut nam eos. Sit eaque officiis ea dolorem.

Adipisci totam rerum corrupti. Dolores repellat provident incidunt omnis eligendi quo excepturi illum. Doloremque architecto ut ab nobis veritatis sint asperiores sint.

Perferendis sint unde harum exercitationem culpa dolor praesentium error. Aliquid aperiam eum aut quaerat. Non aspernatur quam ut qui quia. Quam illum odit rerum cumque.
    <img src="/img/bike.avif" style="
      height: 200px;
      max-width: fit-content; /* Needed to override my site's styles */
      position: absolute;
      top: 0;
      left: 500px;
    " />
  </div>
</div>

In order to make this 100% clear I'll add a diff below

And this text explaining that which should give space

For that absolute-positioned bike to not cover things up

## And here's the diff (ignoring whitespace)

```diff
+<div style="
+  position: relative;
+">
  <div style="
-   position: relative;
    overflow-y: scroll;
    overflow-x: visible;
    max-height: 100px;
    max-width: 500px;
  ">
Here's some content that's too long and scrolls

And a picture of a bike that should be positioned absolute to the right of this text

-Even though the horizontal overflow is set to visible, we get a horizontal scroll
+Now the text scrolls but you can still see the bike sticking out to the side!

Some Lorem ipsum...
    <img src="/img/bike.avif" style="
      height: 200px;
      max-width: fit-content; /* Needed to override my site's styles */
      position: absolute;
      top: 0;
      left: 500px;
    " />
  </div>
+</div>
```

## Why this works

I think what I'm demonstrating here is actually a bit misleading. The contents of the `overflow: scroll` div still scroll on overflow - it's just that the image is no longer really that div's content! Originally the `position: relative` contained the image within the scrolling div, even when the `position: absolute` pulled the image out of the flow. In the fixed version, the image is still pulled out of the flow, but is pulled outside the scrolling div entirely.

I think my explanation is too confusing, here's code instead:

```html
<div style="
  position: relative;
">
  <div style="
    overflow-y: scroll;
    overflow-x: visible;
    max-height: 100px;
    max-width: 500px;
  ">
    <div style="
      position: relative;
    ">
  I really want the bike to be positioned based on this inner div
      <img src="/img/bike.avif" style="
        height: 200px;
        max-width: fit-content; /* Needed to override my site's styles */
        position: absolute;
        top: 0;
        left: 500px;
      " />
    </div>
  </div>
</div>
```

<div style="
  position: relative;
">
  <div style="
    overflow-y: scroll;
    overflow-x: visible;
    max-height: 100px;
    max-width: 500px;
  ">
    <div style="
      position: relative;
    ">
  I really want the bike to be positioned based on this inner div
      <img src="/img/bike.avif" style="
        height: 200px;
        max-width: fit-content; /* Needed to override my site's styles */
        position: absolute;
        top: 0;
        left: 500px;
      " />
    </div>
  </div>
</div>

Because the inner div is entirely withing the scrolling div, everything gets scrolled.

I'm encountering this version of the problem in the header on this site. If you hover over a link, a hand will pop up. I have the header constrained by `overflow-x: hidden` because I can't figure out sizing my buttons well for small screens. I need the links to be `position: relative` so the hand moves relative to the link, not to the side of the header. As the link is within the header, the hand stays within the header, and it all gets affected by the overflow logic.

As such, I'm headed back to the drawing board for this case, but it's sure useful to know of this interaction!

