---
name: Kinetic Horizon
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#4a4453'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#7b7485'
  outline-variant: '#ccc3d5'
  surface-tint: '#703fc8'
  primary: '#420092'
  on-primary: '#ffffff'
  primary-container: '#5a24b1'
  on-primary-container: '#c7aaff'
  inverse-primary: '#d3bbff'
  secondary: '#964900'
  on-secondary: '#ffffff'
  secondary-container: '#fd8a30'
  on-secondary-container: '#642e00'
  tertiary: '#003b27'
  on-tertiary: '#ffffff'
  tertiary-container: '#005439'
  on-tertiary-container: '#00d294'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ebddff'
  primary-fixed-dim: '#d3bbff'
  on-primary-fixed: '#250059'
  on-primary-fixed-variant: '#5821af'
  secondary-fixed: '#ffdcc7'
  secondary-fixed-dim: '#ffb787'
  on-secondary-fixed: '#311300'
  on-secondary-fixed-variant: '#723600'
  tertiary-fixed: '#57febc'
  tertiary-fixed-dim: '#2de0a1'
  on-tertiary-fixed: '#002114'
  on-tertiary-fixed-variant: '#005237'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  display-lg:
    fontFamily: Hanken Grotesk
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  headline-md:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.04em
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  base: 8px
  container-max: 1280px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 64px
  stack-sm: 12px
  stack-md: 24px
  stack-lg: 48px
---

## Brand & Style

The design system is engineered for a commercial marketplace that bridges the gap between traditional real estate and modern entrepreneurship. The brand personality is **ambitious, reliable, and fluid**, designed to evoke a sense of professional possibility and "launch-ready" confidence. 

The aesthetic direction is **Premium Corporate Modern**. It borrows the rigorous usability and "listing-first" clarity of major travel marketplaces but elevates it with a more vibrant, energetic color palette derived from the brand's identity. The visual language relies on extreme clarity, expansive whitespace to denote high-end service, and large-scale radius values that make the professional environment feel accessible and contemporary. It balances the "trust" required for legal contracts with the "innovation" required for new business ventures.

## Colors

The palette is rooted in a deep **Imperial Purple** (Primary), which provides the structural weight and "premium" feel. This is contrasted by **Solar Orange** (Secondary), used sparingly for high-intent actions like primary "Book Now" buttons or "New" badges to create urgency and energy. **Mint Emerald** (Tertiary) is utilized for success states, verification marks, and "Available" indicators, signaling growth and safety.

The neutral scale favors cool slates over pure greys to maintain a modern, tech-forward atmosphere. Surfaces are predominantly white to maximize the "Airbnb-style" airy feel, using subtle grey washes to separate content sections without adding visual noise.

## Typography

This design system utilizes **Hanken Grotesk** for headings to provide a sharp, contemporary "designer" edge that differentiates the platform from standard corporate templates. For all functional text, data, and descriptions, **Inter** is used for its peerless legibility and neutral, systematic character.

Headlines should use tight letter-spacing and bold weights to command attention, while body text maintains generous line-heights to ensure that long-form property descriptions remain digestible and professional. Label styles are frequently uppercased or semi-bolded to create clear hierarchy in metadata-heavy views.

## Layout & Spacing

The layout philosophy follows a **Fluid-Fixed Hybrid** model. Content is contained within a 1280px max-width wrapper on desktop to ensure readability, while the background and secondary navigation elements may bleed to the edges. 

We employ a 12-column grid for desktop property listings and a 1-column layout for mobile. Gutters are kept wide (24px) to emphasize the premium whitespace. Internal component padding should be generous—listing cards should never feel cramped, often using 24px of internal padding to frame images and text appropriately.

## Elevation & Depth

Visual hierarchy is established through **Ambient Tinted Shadows** and **Tonal Layering**. 

1.  **Level 0 (Floor):** The main background (`#FFFFFF`).
2.  **Level 1 (Cards/Search):** Uses an extremely soft, diffused shadow: `0px 4px 20px rgba(15, 23, 42, 0.05)`. This creates a floating effect without sharp edges.
3.  **Level 2 (Active States/Modals):** A deeper shadow with a slight purple tint in the umbra to tie back to the brand: `0px 12px 32px rgba(90, 36, 177, 0.08)`.

Floating Action Buttons (FABs) and the primary search bar use these shadows to appear "lifted" above the content, inviting immediate interaction.

## Shapes

The shape language is defined by **High-Radius Geometry**. Following the "Pill-shaped" philosophy (Level 3), main listing cards use a **24px (rounded-lg)** or **32px (rounded-xl)** corner radius to mirror the approachable, friendly curves of the brand mark. 

Buttons and input fields use fully rounded ends (pill-shaped) to maximize the modern, friendly aesthetic. This organic curvature softens the "industrial" nature of commercial real estate, making the platform feel like a modern service rather than a sterile listing site.

## Components

### Cards
Listing cards feature a large image container with a `aspect-ratio: 4/3`. Images must have a 24px top-corner radius. The footer of the card uses `body-md` for the title and `label-sm` for the location, with the price prominently displayed in the bottom right using the Primary color.

### Primary Search Bar
The search bar is the centerpiece. It should be a large, pill-shaped container with an elevation of Level 1. It utilizes vertical dividers between "Location", "Type", and "Dates" inputs. The search button is a simple, high-contrast Solar Orange circle with a white icon.

### Status Badges
Badges use high-contrast color pairings:
- **Available:** Mint Emerald background (10% opacity) with Mint Emerald text.
- **Premium:** Imperial Purple background with white text.
- **New:** Solar Orange background with white text.
All badges use `label-sm` and a pill shape.

### Buttons
- **Primary:** Solar Orange background, white text, pill-shaped, slight hover lift.
- **Secondary:** White background, Imperial Purple border (1.5px), purple text.
- **Ghost:** No border, Primary color text, subtle grey background on hover.

### Inputs
Input fields use a subtle Slate border (`#E2E8F0`) that thickens and changes to Imperial Purple on focus. Labels are always placed above the field in `label-sm`.