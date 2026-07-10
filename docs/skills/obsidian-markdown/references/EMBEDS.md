# Embeds Reference

## Embed Notes

```markdown
![[Note Name]]
![[Note Name#Heading]]
![[Note Name#^block-id]]
```

## Embed Images

```markdown
![[image.png]]
![[image.png|640x480]]    Width x Height
![[image.png|300]]        Width only (maintains aspect ratio)
```

## External Images

```markdown
![Alt text](https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/main/docs/assets/logo.webp)
![Alt text|300](https://raw.githubusercontent.com/galyarderlabs/galyarder-framework/main/docs/assets/logo.webp)
```

## Embed Audio

```markdown
![[audio.mp3]]
![[audio.ogg]]
```

## Embed PDF

```markdown
![[document.pdf]]
![[document.pdf#page=3]]
![[document.pdf#height=400]]
```

## Embed Lists

```markdown
![[Note#^list-id]]
```

Where the list has a block ID:

```markdown
- Item 1
- Item 2
- Item 3

^list-id
```

## Embed Search Results

````markdown
```query
tag:#project status:done
```
````

---
 2026 Galyarder Labs. Galyarder Framework.
