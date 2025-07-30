<script lang="ts">
  import { Avatar, type Size } from '@immich/ui';

  type AvatarColor = 'primary' | 'pink' | 'red' | 'yellow' | 'blue' | 'green' | 'purple' | 'orange' | 'gray' | 'amber';

  type Group = {
    id: string;
    name: string;
    description: string | null;
  };

  interface Props {
    group: Group;
    size?: Size;
  }

  let { group, size }: Props = $props();

  const getAvatarColor = (name: string): AvatarColor => {
    const hash = Array.from(group.name).reduce((acc, char) => acc + char.charCodeAt(0), 0);
    const colors: AvatarColor[] = [
      'primary',
      'pink',
      'red',
      'yellow',
      'blue',
      'green',
      'purple',
      'orange',
      'gray',
      'amber',
    ] as const;
    return colors[hash % colors.length];
  };

  const color = $derived(getAvatarColor(group.name));
</script>

<Avatar name={group.name} {color} {size} />
