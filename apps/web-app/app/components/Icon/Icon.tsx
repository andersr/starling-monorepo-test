import { twMerge } from "tailwind-merge";

/**
 * Icon component that displays Material Symbols Icons and Tailwind for styling
 *
 * @example
 *
 * <Icon iconName="search" iconStyles="text-red-500 text-4xl"/>
 *
 */
export interface IconProps {
  /** Use Material Symbols names for iconName, see https://fonts.google.com/icons */
  iconName: string;

  /** Use Tailwind styling for iconStyles, see https://tailwindcss.com/ */
  iconStyles?: string;
}

export function Icon({ iconName, iconStyles }: IconProps) {
  return (
    <span
      title={iconName}
      className={twMerge("material-symbols-outlined", iconStyles)}
      dangerouslySetInnerHTML={{ __html: iconName }}
    />
  );
}
